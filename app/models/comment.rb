class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  attr_accessible :body, :like, :parent_id

  has_many :sub_comments, :class_name => 'Comment', :foreign_key => :parent_id
  belongs_to :parent_comment, :class_name => 'Comment', :foreign_key => :parent_id

  serialize :body, Array
  serialize :like, Array
  validates_presence_of :body, :user, :post

  def to_hash
    {
      'id' => self.id,
      'body' => self.body.last,
      'like' => self.like.present? ? self.like.count : 0,
      'parent_id' => self.parent_id,
      'user_name' => User.get_user_name(@user),
      'created_at' => self.created_at
    }
  end

  def get_comment_hash
    comment_hash = self.to_hash
    comment_hash.merge!({'has_liked' => self.like.present? && self.like.include?(@user)})
    comment_hash
  end

  def self.get_comments(post,user)
    @user = user
    comments = Comment.where(:post_id => post.id)
    comments.collect do |comment|
      comment.get_comment_hash
    end
  end

end
