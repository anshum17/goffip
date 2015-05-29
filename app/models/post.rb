class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :like, :dislike, :type

  has_many :comments, :dependent => :destroy, :class_name => 'Comment'
  serialize :body, Array
  serialize :like, Array
  serialize :dislike, Array

  validates_presence_of :body, :type, :user

  def self.get_all_posts(params)
    @user = User.get_name_by_id params[:user_id]
    type = PostTypeList.get_index params[:type]
    posts = Post.where('type = ? AND created_at > ?', type, Date.today - 7).includes(:comments)
    posts.collect do |post|
      post.get_post_hash
    end
  end

  def get_post_hash
    post_hash = self.to_hash
    post_hash.merge!({'has_liked' => self.like.present? && self.like.include?(@user)})
    post_hash
  end

  def to_hash
    {
      'id' => self.id,
      'body' => self.body.last,
      'user_name' => @user.user_name,
      'type' => self.type,
      'like' => self.like.present? ? self.like.count : 0,
      'comments' => Comment.get_comments(self,@user),
      'created_at' => self.created_at.to_i
    }
  end

  def self.get_post(post_id)
    post = Post.find(post_id) rescue nil
    return failure_response('Post not found') if post.blank?
    post.get_post_hash
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

  def self.create_post(params)
    if anonymity_check(@user, params[:is_anonymous])
      Post.new(:body => [params[:body]], :type => PostTypeList.get_index(params[:type]))
      return success_message('Post successfully created.')
    else
      return failure_messgage('Weekly anonymity count exceeded')
    end
  end

  def self.update_post(params)
    post = Post.find(params[:id]) rescue nil
    return failure_messgage('Post ID not found') if post.nil?

    post.body.push(params[:body])
    post.save
    return success_message('Post Successfully updated.')
  end

  def self.delete_post(params)
    post = Post.find(params[:id]) rescue nil
    return failure_messgage('Post ID not found') if post.nil?
    post.delete
  end

  private

  def anonymity_check(user, anonymity_flag)
    counter = @user.anonymity_count
    if !anonymity_flag
      return true
    elsif anonymity_flag and counter <= 2
      @user.anonymity_count = counter + 1
      @user.save
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
