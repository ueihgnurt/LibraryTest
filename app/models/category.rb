# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bookcategories, dependent: :destroy
  has_many :books, through: :bookcategories, source: :book
  accepts_nested_attributes_for :bookcategories
  validates :name, presence: true, length: {maximum: 50}
end
