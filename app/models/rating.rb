class Rating < ApplicationRecord
  # Validations
  validates_inclusion_of :value, :in => 0..1
  validates :rating_type, inclusion: { in: [ 'overall' ] }

  # Associations
  belongs_to :user, inverse_of: :ratings
  belongs_to :term, inverse_of: :ratings
end
