class Term < ApplicationRecord
  # Validations
  validates_uniqueness_of :term, :scope => :course
  
  # Associations
  belongs_to :course, inverse_of: :terms
  has_many :ratings, inverse_of: :term
  has_many :lectures, inverse_of: :term
  has_many :enrolments, inverse_of: :term
  has_many :users, through: :enrolments
end
