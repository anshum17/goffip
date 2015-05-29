class User < ActiveRecord::Base
  attr_accessible :anonymity_count, :department, :email, :fb_link, :first_name, :last_name, :session_token

  has_many :posts, :class_name => 'Post'
  has_many :comments, :class_name => 'Comment'

  def self.get_name_by_id(user_id)
    user = User.find(user_id) rescue nil
  end

  def self.get_user_name(user=nil)
    return '' if user.blank?
    return "#{user.first_name} #{user.last_name}"
  end

end
