class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  before_save :create_remember_token
  before_save { |user| user.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(
  	:email,
  	presence: true,
  	format: { with: VALID_EMAIL_REGEX },
  	uniqueness: { case_sensitive: false }
  	)
  validates(
	:password,
	presence: true,
	length: { minimum: 3 }	
	)
  validates(
  	:password_confirmation,
  	presence: true
  	)
  after_validation { self.errors.messages.delete(:password_digest) }
  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end