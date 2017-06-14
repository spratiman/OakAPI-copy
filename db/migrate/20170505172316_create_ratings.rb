class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.references :user, foreign_key: true
      t.integer :value, null: false, default: 3
      t.string :rating_type

      t.timestamps
    end
  end
end
