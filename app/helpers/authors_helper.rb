# frozen_string_literal: true

module AuthorsHelper
  def get_author
    Author.all
  end

  def reverse_list list
    list.reverse
  end
end
