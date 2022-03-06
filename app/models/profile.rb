class Profile < ApplicationRecord
  belongs_to :user
  has_many :posts
  has_one :study
  has_one_attached :image

  # accept_nested_attributes_for :study, update_only: true

  validates :name, presence: true
  validates :name, length: {minimum: 1}
  validates :description, length: {maximum: 100}
end
