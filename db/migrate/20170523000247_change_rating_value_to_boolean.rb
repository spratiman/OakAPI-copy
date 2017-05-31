class ChangeRatingValueToBoolean < ActiveRecord::Migration[5.1]
  def up
    change_column :ratings, :value, :boolean, default: false
  end

  def down
    change_column :ratings, :value, :string, default: 3
  end
end
