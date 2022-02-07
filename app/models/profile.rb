class Profile < ApplicationRecord
  belongs_to :user
  has_many :posts
  has_one_attached :image

  validates :name, presence: true
  validates :name, length: {minimum: 1}
  validates :description, length: {maximum: 100}
end
