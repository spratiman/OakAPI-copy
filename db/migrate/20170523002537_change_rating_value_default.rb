class ChangeRatingValueDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :ratings, :value, nil
  end
end
