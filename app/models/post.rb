class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :like, :dislike, :post_type, :is_anonymous

  has_many :comments, :dependent => :destroy, :class_name => 'Comment'
  serialize :body, Array
  # serialize :like, Array
  # serialize :dislike, Array

  validates_presence_of :body, :post_type, :user

  def self.get_all_posts(params,user)
    post_type = PostTypeList.get_index(params[:post_type].upcase)
    posts = Post.where('post_type = ? AND created_at > ?', post_type, Date.today - 7).includes(:comments)
    posts.collect do |post|
      post.get_post_hash(user)
    end
  end

  def get_post_hash(user)
    post_hash = self.to_hash(user)
    post_hash.merge!({'has_liked' => self.like.present? && self.like.include?(user)})
    post_hash
  end

  def to_hash(user)
    {
      'id' => self.id,
      'body' => self.body.last,
      'user_name' => self.is_anonymous ? 'Anonymous' : user.user_name,
      'post_type' => PostTypeList.get_name(self.post_type),
      'like' => self.like.present? ? self.like.count : 0,
      'comments' => Comment.get_comments(self,user),
      'created_at' => self.created_at.to_i
    }
  end

  def self.get_post(post_id, user)
    @user = user
    post = Post.find(post_id) rescue nil
    return failure_message('Post not found') if post.blank?
    post.get_post_hash(user)
  end

  def self.process_like(params, user)
    # @user = User.get_name_by_id params[:user_id]
    like_status = params[:like] # true or false
    post = Post.find(params[:post_id])
    return if user.blank? || post.blank?
    users_liked_post = post.like.to_s.split(',')
    users_disliked_post = post.dislike.to_s.split(',')
    if users_liked_post.include? user.id.to_s
      return failure_message('Can not like a post twice.') if like_status == "true"
      post.dislike = users_disliked_post.push(user.id.to_s).join(',')
      users_liked_post -= [user.id.to_s]
      post.like = users_liked_post.join(',')
    elsif users_disliked_post.include? user.id.to_s
      return failure_message('Can not dislike a post twice.') if like_status == "false"
      post.like = users_liked_post.push(user.id.to_s).join(',')
      users_disliked_post -= [user.id.to_s]
      post.dislike = users_disliked_post.join(',')
    else
      # like_status ? post.like.push(user.id) : post.dislike.push(user.id)
      if like_status == "true"
        users_liked_post += [user.id.to_s]
        post.like = users_liked_post.join(',')
      else
        users_disliked_post += [user.id.to_s]
        post.dislike = users_disliked_post.join(',')
      end
    end
    post.save
    success_message('Successfully updated')
  end

  def self.create_post(params, user)
    if anonymity_check(user, params[:is_anonymous])
      p = Post.new(:like => '', :dislike => '', :body => [params[:body]], :post_type => PostTypeList.get_index(params[:post_type].upcase))
      p.user = user
      if p.save
        return success_message('Post successfully created.')
      else
        return failure_message(p.errors.messages)
      end
    else
      return failure_message('Weekly anonymity count exceeded')
    end
  end

  def self.update_post(params)
    post = Post.find(params[:id]) rescue nil
    return failure_message('Post ID not found') if post.nil?

    post.body.push(params[:body])
    post.save
    return success_message('Post Successfully updated.')
  end

  def self.delete_post(params)
    post = Post.find(params[:id]) rescue nil
    post.delete
  end

  private

  def self.anonymity_check(user, anonymity_flag)
    counter = user.anonymity_count
    if anonymity_flag == "false"
      return true
    elsif anonymity_flag == "true" and counter < 2
      user.anonymity_count = counter + 1
      user.save
      return true
    else
      return false
    end
  end

  def self.failure_message(message)
    {:message => message, :status => false}
  end

  def self.success_message(message)
    {:message => message, :status => true}
  end

end
