class ChangeUniqueIndexForCodeInCourse < ActiveRecord::Migration[5.1]
  def change
    remove_index :courses, name: 'index_courses_on_code'
    add_index :courses, [:code, :campus], :unique => true
  end
end
