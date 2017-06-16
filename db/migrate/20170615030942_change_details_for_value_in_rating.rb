class ChangeDetailsForValueInRating < ActiveRecord::Migration[5.1]
  def change
    change_column_null :ratings, :value, true
    change_column_default :ratings, :value, false
  end
end
