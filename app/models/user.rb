class User < ApplicationRecord
  has_many :anons, dependent: :destroy
  has_secure_password
  has_many :comments

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
end
