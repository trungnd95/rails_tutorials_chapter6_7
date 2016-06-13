class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
	attr_accessor :remember_token, :activation_token
	before_create :confirmation_token
	before_save {self.email = email.downcase}
	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255},
			format: {with: VALID_EMAIL_REGEX},
			uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, presence: true, length: {minimum: 6}
	private 
	# Creates and assigns the activation token and digest.
 #    def create_activation_digest
 #      self.activation_token  = User.new_token
 #      self.activation_digest = User.digest(activation_token)
 #    end
	# class << self
	#    # Returns the hash digest of the given string.
	#    def User.digest(string)
	#     	# cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
	#     	# BCrypt::Engine.cost
	#     	cost = 10
	#     	BCrypt::Password.create(string, cost: cost)
	#     end

	#   	# Returns a random token.
	#   	def User.new_token
	#   		SecureRandom.urlsafe_base64
	#   	end
	# end
	
	public 
	def create_reset_digest
		if self.reset_digest.blank?
			self.reset_digest = SecureRandom.urlsafe_base64.to_s
			self.reset_sent_at = Time.zone.now
			update_attributes(:reset_digest => reset_digest, :reset_sent_at => reset_sent_at)
		end 
	end
	private
	def confirmation_token
		if self.activation_digest.blank?
			self.activation_digest = SecureRandom.urlsafe_base64.to_s
		end
	end
end
