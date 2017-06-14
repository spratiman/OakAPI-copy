class Enrolment < ApplicationRecord
  # Associations
  belongs_to :user, inverse_of: :enrolments
  belongs_to :term, inverse_of: :enrolments
end
