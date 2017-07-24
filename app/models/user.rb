class User < ApplicationRecord
  # Include devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable,
          :validatable, :confirmable

  # Validations
  validates_presence_of :email, :password, :name, :nickname
  validates_uniqueness_of :email

  # Associations
  has_many :comments, inverse_of: :user
  has_many :ratings, inverse_of: :user
  has_many :enrolments, inverse_of: :user
  has_many :terms, through: :enrolments
end
