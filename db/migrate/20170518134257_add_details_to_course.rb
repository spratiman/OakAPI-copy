class AddDetailsToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :department, :string
    add_column :courses, :division, :string
    add_column :courses, :level, :integer
    add_column :courses, :campus, :string
  end
end
