class User < ActiveRecord::Base
  has_many :products
  has_many :purchases
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :first_name, :last_name, :presence => true, :length => { minimum: 2 }
  validates :email, :presence => true, :format => { with: EMAIL_REGEX }, :uniqueness => { case_sensitive: false }
  validates :password, :presence => true, :length => { minimum: 8 }, :if => "!password.nil?"

  before_save :downcase_email
  private
    def downcase_email
      self.email.downcase!
    end
end
