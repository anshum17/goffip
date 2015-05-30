class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  attr_accessible :body, :like, :dislike, :parent_id, :is_anonymous

  has_many :sub_comments, :class_name => 'Comment', :foreign_key => :parent_id
  belongs_to :parent_comment, :class_name => 'Comment', :foreign_key => :parent_id

  serialize :body, Array
  # serialize :like, Array
  # serialize :dislike, Array
  validates_presence_of :body, :user, :post

  def self.create_comment(params, user)
    c = Comment.new(:like => '', :dislike => '',:body => [params[:body]], :parent_id => params[:parent_id], :is_anonymous => params[:is_anonymous])
    c.post = Post.find(params[:post_id])
    c.user = user
    if c.save
      return success_message('Comment successfully created.')
    else
      return failure_messgage(c.errors.messages)
    end
  end

  def self.update_comment(params)
    comment = Comment.find(params[:id]) rescue nil
    return failure_messgage('Comment ID not found') if comment.nil?

    comment.body.push(params[:body])
    comment.save
    return success_message('Comment Successfully updated.')
  end

  def to_hash(user)
    {
      'id' => self.id,
      'body' => self.body.last,
      'like' => self.like.present? ? self.like.count : 0,
      'parent_id' => self.parent_id.blank? ? '' : self.parent_id,
      'user_name' => self.is_anonymous ? 'Anonymous' : user.user_name,
      'created_at' => self.created_at.to_i
    }
  end

  def get_comment_hash(user)
    comment_hash = self.to_hash(user)
    comment_hash.merge!(
      {
        'has_liked' => self.like.present? && self.like.include?(user),
        'can_comment_anonymously' => self.post.user_id == user.id && self.post.is_anonymous
      }
    )
    comment_hash
  end

  def self.get_comments(post,user)
    comments = Comment.where(:post_id => post.id)
    comments.collect do |comment|
      comment.get_comment_hash(user)
    end
  end

  def self.process_like(params, user)
    like_status = params[:like] # true or false
    comment = Comment.find(params[:comment_id])
    return if user.blank? || comment.blank?
    users_liked_comment = comment.like.to_s.split(',')
    users_disliked_comment = comment.dislike.to_s.split(',')
    if users_liked_comment.include? user.id.to_s
      return failure_message('Can not like a comment twice.') if like_status == "true"
      comment.dislike = users_disliked_comment.push(user.id.to_s).join(',')
      users_liked_comment -= [user.id.to_s]
      comment.like = users_liked_comment.join(',')
    elsif users_disliked_comment.include? user.id.to_s
      return failure_message('Can not dislike a comment twice.') if like_status == "false"
      comment.like = users_liked_comment.push(user.id.to_s).join(',')
      users_disliked_comment -= [user.id.to_s]
      comment.dislike = users_disliked_comment.join(',')
    else
      # like_status ? comment.like.push(user.id) : comment.dislike.push(user.id)
      if like_status == "true"
        users_liked_comment += [user.id.to_s]
        comment.like = users_liked_comment.join(',')
      else
        users_disliked_comment += [user.id.to_s]
        comment.dislike = users_disliked_comment.join(',')
      end
    end
    comment.save
    success_message('Successfully updated')
  end

  def self.delete_post(params)
    comment = Comment.find(params[:id]) rescue nil
    return failure_messgage('Comment ID not found') if comment.nil?
    comment.delete
  end

  private

  def self.failure_message(message)
    {:message => message, :status => false}
  end

  def self.success_message(message)
    {:message => message, :status => true}
  end

end
