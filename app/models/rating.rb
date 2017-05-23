class Rating < ApplicationRecord
  validates :value, inclusion: { in: [ true, false ] }
  validates :rating_type, inclusion: { in: [ 'overall' ] }
  belongs_to :user
  belongs_to :course
end
