# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :author
  has_many :bookcategories, dependent: :destroy
  has_many :categories, through: :bookcategories
  accepts_nested_attributes_for :bookcategories, allow_destroy: true
  has_many :requests, dependent: :destroy
  has_many :users, through: :requests
  validates :name, presence: true, length: {maximum: 50}
  validates :quantity, presence: true, length: {maximum: 1000}
  has_attached_file :book_img,
                    styles: {book_index: "250x350>", book_show: "325x475>"},
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :book_img, content_type: %r{\Aimage/.*\z}
end
