class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :user_courses
  has_many :courses, through: :user_courses
  has_many :comments, inverse_of: :user
  has_many :ratings
end
