class CreateLectures < ActiveRecord::Migration[5.1]
  def change
    create_table :lectures do |t|
      t.references :term, foreign_key: true
      t.string :code
      t.string :time
      t.string :instructor

      t.timestamps
    end
  end
end
