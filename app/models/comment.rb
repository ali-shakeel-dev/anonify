class Comment < ApplicationRecord
  belongs_to :anon
  belongs_to :user
  validates :content, presence: true
end
