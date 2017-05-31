class RemoveRatingValueNull < ActiveRecord::Migration[5.1]
  def change
    change_column_null :ratings, :value, true
  end
end
