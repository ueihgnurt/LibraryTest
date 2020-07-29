class Cart < ApplicationRecord
  belongs_to :user
  has_many :requests, dependent: :destroy
  has_many :books, through: :request, source: :book
  enum verify: {Accepted: 1,Decline: 2,Queue: 0,Cart: 3}
  scope :list, -> { where verify: !3}
end
