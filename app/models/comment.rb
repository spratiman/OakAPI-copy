class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_ancestry :orphan_strategy => :restrict
end
