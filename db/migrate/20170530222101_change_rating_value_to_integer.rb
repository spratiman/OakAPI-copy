class ChangeRatingValueToInteger < ActiveRecord::Migration[5.1]
  def up
    change_column :ratings, :value, :integer
  end

  def down
    change_column :ratings, :value, :boolean
  end
end
