class User < ApplicationRecord
  after_create :create_cart
  devise :database_authenticatable, :registerable,
         :rememberable
  validates :email, uniqueness: {case_sensitive: false}
  has_many :carts, dependent: :destroy
  has_many :books, through: :cart

  def create_cart
    carts.create(verify: 3) if save
  end
end
