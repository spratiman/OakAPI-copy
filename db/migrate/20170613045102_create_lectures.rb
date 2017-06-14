class CreateLectures < ActiveRecord::Migration[5.1]
  def change
    create_table :lectures do |t|
      t.string :code
      t.string :time
      t.string :instructor

      t.timestamps
    end
  end
end
