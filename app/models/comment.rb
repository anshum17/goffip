class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  attr_accessible :body, :like, :dislike, :parent_id

  has_many :sub_comments, :class_name => 'Comment', :foreign_key => :parent_id
  belongs_to :parent_comment, :class_name => 'Comment', :foreign_key => :parent_id

  serialize :body, Array
  serialize :like, Array
  serialize :dislike, Array
  validates_presence_of :body, :user, :post

  def self.create_comment(params, user)
    c = Comment.new(:body => [params[:body]], :post_id => params[:post_id])
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

  def to_hash
    {
      'id' => self.id,
      'body' => self.body.last,
      'like' => self.like.present? ? self.like.count : 0,
      'parent_id' => self.parent_id,
      'user_name' => @user.user_name,
      'created_at' => self.created_at
    }
  end

  def get_comment_hash
    comment_hash = self.to_hash
    comment_hash.merge!(
      {
        'has_liked' => self.like.present? && self.like.include?(@user),
        'can_comment_anonymously' => self.post.user_id == @user.id && self.post.is_anonymous
      }
    )
    comment_hash
  end

  def self.get_comments(post,user)
    @user = user
    comments = Comment.where(:post_id => post.id)
    comments.collect do |comment|
      comment.get_comment_hash
    end
  end

  def self.process_like(params)
    @user = User.get_name_by_id params[:user_id]
    like_status = params[:like]
    comment = Post.find(params[:comment_id])
    return if @user.blank? || comment.blank?
    users_liked_comment = comment.like
    users_disliked_comment = comment.dislike
    if users_liked_comment.include? @user
      return failure_response('Can not like a comment twice.') if like_status == true
      comment.like.push(@user_id)
    elsif users_disliked_comment.include? @user
      return failure_response('Can not dislike a comment twice.') if like_status == false
      comment.dislike.push(@user_id)
    else
      like_status ? comment.like.push(@user_id) : comment.dislike.push(@user_id)
    end
    comment.save
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
