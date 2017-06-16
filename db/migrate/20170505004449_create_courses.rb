class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :code
      t.string :title
      t.text :description
      t.text :exclusions
      t.text :prerequisites
      t.text :breadths
      t.string :department
      t.string :division
      t.integer :level
      t.string :campus
      
      t.timestamps
    end
    add_index :courses, :code, unique: true
  end
end
