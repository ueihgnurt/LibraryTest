# frozen_string_literal: true

class Bookcategory < ApplicationRecord
  belongs_to :book
  belongs_to :category
end
