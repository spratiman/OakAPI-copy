class RemoveExclusionFromCourse < ActiveRecord::Migration[5.1]
  def change
    remove_column :courses, :exclusions, :text
  end
end
