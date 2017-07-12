class User < ApplicationRecord
  # Include devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable,
          :validatable, :confirmable

  # Validations
  validates :name, :nickname, presence: true
  validates :email, uniqueness: true, presence: true

  # Associations
  has_many :comments, inverse_of: :user
  has_many :ratings, inverse_of: :user
  has_many :enrolments, inverse_of: :user
  has_many :terms, through: :enrolments
end
