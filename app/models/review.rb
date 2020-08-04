class Review < ApplicationRecord
    belongs_to :user
    belongs_to :book

    validates :user_id, presence: true
    validates :book_id, presence: true, uniqueness: { scope: :user_id }

    validates :rating, presence: true
    validates :comment, length: {maximum: 500}
end
