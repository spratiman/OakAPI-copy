class Lecture < ApplicationRecord
  # Validations
  
  # Associations
  belongs_to :term, inverse_of: :lectures
end
