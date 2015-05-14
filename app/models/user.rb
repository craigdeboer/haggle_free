class User < ActiveRecord::Base

  has_many :listings, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :questions, dependent: :destroy

	attr_accessor :remember_token
	before_save { self.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	VALID_USER_NAME_REGEX = /\A[a-z]+[a-z0-9]+\z/i
	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true
	validates :user_name, presence: true, length: { in: 6..50 }, 
						format: { with: VALID_USER_NAME_REGEX, 
						message: "must start with a letter and contain only numbers and letters" },
						uniqueness: { case_sensitive: false }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
	has_secure_password

	# Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
  	self.remember_token = User.new_token
  	self.update_attribute(:remember_digest, User.digest(self.remember_token))
  end

  def authenticated?(remember_token)
  	return false if remember_digest.nil?
  	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    self.update_attribute(:remember_digest, nil)
  end
	
end
