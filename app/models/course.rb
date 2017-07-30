class Course < ApplicationRecord
  # Validations
  validates_presence_of :title, :code, :department, :division, :campus, :level
  validates_uniqueness_of :code, :scope => :campus

  # Associations
  has_many :terms, inverse_of: :course
  has_many :comments, inverse_of: :course
end
