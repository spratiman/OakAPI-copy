class Rating < ApplicationRecord
  validates :value, inclusion: { in: [ true, false ] }
  validates :rating_type, inclusion: { in: [ 'Overall' ] }
  belongs_to :user
  belongs_to :course
end
