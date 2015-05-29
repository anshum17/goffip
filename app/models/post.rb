class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :like, :type

  has_many :comments, :dependent => :destroy, :class_name => 'Comment'
  serialize :body, Array
  serialize :like, Array

  validates_presence_of :body, :type, :user

  def self.get_all_posts(user_id)
    @user = User.get_name_by_id user_id
    posts = Post.where('created_at > ?', Date.today - 7).includes(:comments)
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


  def self.create_post(params)
    create(:body => params[:body], :type => PostTypeList.get_index(params[:type]))
  end

  def self.update_post(params)
    post = Post.find(params[:id]) rescue nil
    return failure_messgage('Post ID not found') if post.nil?

    post.update_attributes(:body => params[:body])
    return success_message('Post Successfully updated.')
  end


  private

  def self.failure_message(message)
    {:message => message, :status => false}
  end

  def self.success_message(message)
    {:message => message, :status => true}
  end
end
