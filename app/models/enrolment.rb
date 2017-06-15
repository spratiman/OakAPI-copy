class Enrolment < ApplicationRecord
  # Associations
  belongs_to :user, inverse_of: :enrolments
  belongs_to :term, inverse_of: :enrolments

  # Validations
  validates_uniqueness_of :user_id, :scope => "term_id"
end
