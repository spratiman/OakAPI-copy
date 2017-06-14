class CreateEnrolments < ActiveRecord::Migration[5.1]
  def change
    create_table :enrolments do |t|
      t.integer :user_id
      t.integer :term_id
      
      t.timestamps
    end
  end
end
