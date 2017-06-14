class AddDetailsFromCourseToTerm < ActiveRecord::Migration[5.1]
  def change
    add_column :terms, :description, :text
    add_column :terms, :eclusions, :text
    add_column :terms, :prerequisites, :text
    add_column :terms, :breadths, :text
  end
end
