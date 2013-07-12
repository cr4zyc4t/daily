require 'digest'
class User < ActiveRecord::Base

	validates :email, :uniqueness => true, 
						:length => { :within => 5..50 }, 
						:format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
	validates :password, :confirmation => true, 
						:length => { :within => 4..20 }, 
						:presence => true, 
						:if => :password_required?
						 
	validates :level, :uniqueness => { :scope => :group_id, :message => ": Only one leader for one group!" },
	                 :if => :is_leader?
						
	attr_accessible :email, :password, :group_id, :level, :password_confirmation
	attr_accessor :password, :password_confirmation

	belongs_to :group
	has_many :reports, :dependent => :destroy

	before_save :encrypt_new_password 

	def self.authenticate(email, password) 
		user = find_by_email(email) 
		return user if user && user.authenticated?(password) 
	end
	
	def authenticated?(password) 
		self.hashed_password == encrypt(password) 
	end
	
	
	def chuc_vu(user)
		if user.level == 3 
			return "Admin"
		elsif user.level == 2 
			return "Leader"
		elsif user.level == 1 
			return "Employee"
		else return "Not Actived"
		end
	end
	
	def phong(id)
		begin 
			return Group.find(id).name
		rescue ActiveRecord::RecordNotFound 
			return "Un Group"
		end
	end
	
	protected 
	
	def is_leader?
	  self.level == 2
	end
	
	def encrypt_new_password 
		return if password.blank? 
		self.hashed_password = encrypt(password) 
	end
	
	def password_required? 
		hashed_password.blank? || password.present? 
	end
	
	def encrypt(string) 
		Digest::MD5.hexdigest(string) 
	end
	
	
end