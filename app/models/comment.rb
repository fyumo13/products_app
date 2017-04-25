class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  validates :content, :user, :product, :presence => true
end
