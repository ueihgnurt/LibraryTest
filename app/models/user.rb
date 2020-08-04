class User < ApplicationRecord
  after_create :create_cart
  validates :email, uniqueness: {case_sensitive: false}
  has_many :carts, dependent: :destroy
  has_many :books, through: :cart
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  validates :name, presence: true, length: {maximum: Settings.NAME}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: {maximum: Settings.EMAIL},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.PW}, allow_nil: true
  scope :lastest, ->{order created_at: :DESC}
  #ManytoMany User_Review_Book
	has_many :reviews, dependent: :destroy
	has_many :reviewed_books, through: :reviews, source: :book

  def create_cart
    carts.create(verify: 3) if save
  end

  def self.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated? attribute,remember_token
    digest = send("#{attribute}_digest")
    return false unless remember_digest
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def lastest; end

  private

  def downcase_email
    self.email = email.downcase
  end

end
