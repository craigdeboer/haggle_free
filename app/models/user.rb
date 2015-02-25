class User < ActiveRecord::Base

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
	
end
