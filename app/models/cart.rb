# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  has_many :requests, dependent: :destroy
  has_many :books, through: :request, source: :book
  scope :find_relcart, ->(_id) { where(id: :id) }
  scope :carts_admin, -> { where "verify not like '3'" }
end
