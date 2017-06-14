class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable,
          :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  # Validations
  validates :name, :nickname, presence: true
  validates :email, uniqueness: true, presence: true

  # Associations
  has_many :user_courses
  has_many :terms, through: :user_courses
  has_many :comments, inverse_of: :user
  has_many :ratings, inverse_of: :user
end
