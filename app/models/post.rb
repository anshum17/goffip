class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :like, :type

  has_many :comments, :class_name => 'Comment'
  serialize :body, Array
  serialize :like, Array

  validates_presence_of :body, :type, :user

  def self.get_all_posts(params)
    @user = User.get_name_by_id params[:user_id]
    type = PostTypeList.get_index params[:type]
    posts = Post.where('type = ? AND created_at > ?', type, Date.today - 7).includes(:comments)
    posts.collect do |post|
      post.to_hash
    end
  end

  def to_hash
    {
      'id' => self.id,
      'body' => self.body.last,
      'user_name' => User.get_user_name(@user),
      'type' => self.type,
      'like' => self.like.present? ? self.like.count : 0,
      'comments' => Comment.get_comments(self,@user),
      'created_at' => self.created_at.to_i
    }
  end

  def self.get_post(post_id)
    post = Post.find(post_id) rescue nil
    return failure_response('Post not found') if post.blank?
    post.to_hash
  end

  def self.process_like(params)
    @user = User.get_name_by_id params[:user_id]
    like_status = params[:like]
    post = Post.find(params[:post_id])
    return if @user.blank? || post.blank?
    users_liked_post = post.like
    users_disliked_post = post.dislike
    if users_liked_post.include? @user
      return failure_response('Can not like a post twice.') if like_status == true
      post.like.push(@user_id)
    elsif users_disliked_post.include? @user
      return failure_response('Can not dislike a post twice.') if like_status == false
      post.dislike.push(@user_id)
    else
      like_status ? post.like.push(@user_id) : post.dislike.push(@user_id)
    end
    post.save
  end

  def self.failure_response(message)
    {
      'message' => message,
      'status' => false
    }
  end

end
