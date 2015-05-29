class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :like, :type
  # serialize :body, :type

  has_many :comments, :dependent => :destroy, :class_name => 'Comment'

  # def self.get_all_posts
  #   posts = Post.
  # end


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
