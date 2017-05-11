class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_ancestry
end
