class CreateUserCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :user_courses do |t|
      t.integer :user_id
      t.integer :course_id
      t.text :body
      t.boolean :has_dropped
      t.boolean :is_waitlisted

      t.timestamps
    end
  end
end
