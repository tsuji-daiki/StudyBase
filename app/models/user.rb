class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_one :profile
  has_many :studies

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
