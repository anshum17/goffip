class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :like, :type

  has_many :comments, :class_name => 'Comment'
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

end
