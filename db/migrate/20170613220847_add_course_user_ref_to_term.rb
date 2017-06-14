class AddCourseUserRefToTerm < ActiveRecord::Migration[5.1]
  def change
    add_reference :terms, :user, foreign_key: true
    add_reference :terms, :course, foreign_key: true
    add_index :terms, [:user_id, :course_id], unique: true
  end
end
