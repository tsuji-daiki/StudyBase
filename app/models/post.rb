class Post < ApplicationRecord
  has_many :comments
  belongs_to :profile
  belongs_to :user


  validates :content, length: {maximum: 100}
end
