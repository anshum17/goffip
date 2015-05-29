class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :like, :type
  # serialize :body, :type

  has_many :comments, :class_name => 'Comment'

  # def self.get_all_posts
  #   posts = Post.
  # end

end
