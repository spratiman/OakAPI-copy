class Rating < ApplicationRecord
  validates_inclusion_of :value, :in => 0..1
  validates :rating_type, inclusion: { in: [ 'overall' ] }
  #validates_uniqueness_of :user_id
  belongs_to :user
  belongs_to :course
end
