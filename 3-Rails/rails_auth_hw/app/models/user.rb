class User < ApplicationRecord
  attr_reader :password

  before_validation :ensure_session_token
  
  validates :username, presence: true
  validates :session_token, presence: true
  validates :password_digest, presence: { message: 'Password can\'t be blank' }
  validates :password, length: {minimum: 6, allow_nil: true}
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end

