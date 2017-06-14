class AddUniqueIndexToRating < ActiveRecord::Migration[5.1]
  def change
    add_index :ratings, [:user_id, :term_id, :rating_type], unique: true
  end
end
