class User < ActiveRecord::Base
  attr_accessible :anonymity_count, :department, :email, :fb_link, :first_name, :last_name, :session_token

  has_many :posts, :class_name => 'Post'
  has_many :comments, :class_name => 'Comment'

  before_save :validate_email

  validate_uniqueness_of :username

  def self.get_name_by_id(user_id)
    user = User.find(user_id) rescue nil
  end

  def self.get_user_name(user=nil)
    return '' if user.blank?
    return "#{user.first_name} #{user.last_name}"
  end

  def create_user(params)
    user = User.new(params)
    user.session_token  = user.get_session_token()
    user.save
  end

  def get_profile()
    {
      'first_name'      => self.first_name,
      'last_name'       => self.last_name,
      'user_name'       => self.username,
      'anonymity_count' => self.anonymity_count,
      'email'           => self.email,
      'fb_link'         => self.fb_link,
      'department'      => DepartmentList.get_index(self.department)
    }
  end

  def update_profile(params)
    self.update_attributes(:department => DepartmentList.get_index(params[:department]))
  end

  def validate_email

  end

  def get_session_token
    if self.session_token.blank?
     self.session_token = self.id.to_s + SecureRandom.base64(64).gsub(/[$=+\/]/,65.+(rand(25)).chr)
     self.save
    end
    return self.session_token
  end

end
