class User < ApplicationRecord
  has_many :announcements, dependent: :destroy
  enum roles: { admin: "admin", user: "user" }
  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { maximum: 50, minimum: 3 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255, minimum: 5 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 5 }, allow_nil: true
end
