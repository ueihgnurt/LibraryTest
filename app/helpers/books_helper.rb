# frozen_string_literal: true

module BooksHelper
  def get_quantity(book_id)
    return Book.find(book_id)&.quantity
  end

  def get_book
    Book.all
  end

  def get_category
    Category.all
  end
end
