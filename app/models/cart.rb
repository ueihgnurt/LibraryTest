class Cart < ApplicationRecord
  belongs_to :user
  has_many :requests, dependent: :destroy
  has_many :books, through: :request, source: :book

  scope :carts_admin, -> {where "verify not like '3'"} 
end
