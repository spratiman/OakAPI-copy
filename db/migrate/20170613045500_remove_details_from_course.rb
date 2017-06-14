class RemoveDetailsFromCourse < ActiveRecord::Migration[5.1]
  def change
    remove_column :courses, :description, :text
    remove_column :courses, :prerequisites, :text
    remove_column :courses, :breadths, :text
    remove_column :courses, :exclusions, :text
  end
end
