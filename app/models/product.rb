class Product < ActiveRecord::Base
  belongs_to :user
  has_many :purchases, dependent: :destroy
  has_many :users, through: :purchases
  PRICE_REGEX = /(\d+\.\d{1,2})/

  validates :name, :presence => true, :uniqueness => { case_sensitive: false }
  validates :description, :user, :presence => true
  validates :price, :presence => true, :format => { with: PRICE_REGEX }, :numericality => { greater_than: 0 }
end
