class Comment < ApplicationRecord
  attr_readonly :user, :course

  # Validations
  validates :body, :user, :course, presence: true
  validate :depth_cannot_be_greater_than_five
  validate :course_is_not_different_from_parent_course
  
  # Associations
  belongs_to :user
  belongs_to :course
  has_ancestry :orphan_strategy => :restrict

  private

  def depth_cannot_be_greater_than_five
    if self.depth > 5
      errors.add(:id, "depth can\'t be greater than five")
    end
  end

  def course_is_not_different_from_parent_course
    if !self.is_root? && self.course != self.parent.course
      errors.add(:course, "cannot be different from parent comment course")
    end
  end
end
