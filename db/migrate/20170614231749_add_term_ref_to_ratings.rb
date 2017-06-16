class AddTermRefToRatings < ActiveRecord::Migration[5.1]
  def change
    add_reference :ratings, :term, foreign_key: true
  end
end
