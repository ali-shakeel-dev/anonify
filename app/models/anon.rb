class Anon < ApplicationRecord
  validates :title, :description, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
end
