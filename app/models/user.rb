class User < ApplicationRecord
  has_many :favourites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favourite_movies, through: :favourites, source: :movie
  has_secure_password

  validates :username, presence: true,
                     format: { with: /\A[A-Z0-9]+\z/i },
                     uniqueness: { case_sensitive: false }

  validates :name, presence: true

  validates :email, presence: true,
                    format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 10, allow_blank: true }

  def gravatar_id
    Digest::MD5.hexdigest(email.downcase)
  end
end
