class UserCourse < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :course
end
