class User < ActiveRecord::Base
	validates_presence_of :user_name,:password, :password_confirmation, :user_email
	validates :user_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
	has_one :profile
	has_many :categories
	attr_accessor :password_confirmation
end
