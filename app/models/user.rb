class User < ActiveRecord::Base
  attr_accessible :anonymity_count, :department, :email, :fb_link, :first_name, :last_name, :session_token, :user_name

  has_many :posts, :class_name => 'Post'
  has_many :comments, :class_name => 'Comment'

  validates_uniqueness_of :user_name

  validates_presence_of :email, :first_name, :last_name, :user_name#, :session_token
  validates_uniqueness_of :user_name

  before_save :get_session_token
  before_save :validate_email

  include PgSearch
  pg_search_scope :search, against: [:first_name, :last_name],
    using: {tsearch: {dictionary: "english", prefix: true, any_word: true}}

  def self.get_name_by_id(user_id)
    user = User.find(user_id) rescue nil
  end

  def self.get_full_name(user=nil)
    return '' if user.blank?
    return "#{user.first_name} #{user.last_name}"
  end

  def create_user(params)
    user = User.new(params)
    user.session_token  = user.get_session_token()
    if user.save
      return {:message => 'User Successfully created', :status => true, :user => user}
    else
      return {:message => user.errors.messages, :status => false, :user => nil}
    end
  end

  def get_profile
    {
      'first_name'      => self.first_name,
      'last_name'       => self.last_name,
      'user_name'       => self.user_name,
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

  def reset_anonymity_count
    User.update_all(:anonymity_count => 0)
  end

  def self.app_search(query)
    results = text_search(query)
    results.collect do |user|
      user.to_hash
    end
  end

  def self.text_search(query)
    if query.present?
      search(query)
    end
  end

  def to_hash
    {
      'id' => self.id,
      'first_name' => self.first_name.present? ? self.first_name : '',
      'last_name' => self.last_name.present? ? self.last_name : '',
      'department' => self.department.present? ? self.department : '',
      'email' => self.email.present? ? self.email : '',
      'fb_link' => self.fb_link.present? ? self.fb_link : '',
      'user_name' => self.user_name.present? ? self.user_name : ''
    }
  end

  private

  def self.failure_message(message)

  end

  def self.success_message(message)

  end

end
