class ChangeRatingValueToBoolean < ActiveRecord::Migration[5.1]
  def up
    # create the new column with a temporary name
    add_column :ratings, :convert_value, :boolean, default: false
    # remove the older value column
    remove_column :ratings, :value
    # rename the convert_value to value column
    rename_column :ratings, :convert_value, :value
  end

  def down
    # create the new column with a temporary name
    add_column :ratings, :convert_value, :string, default: 3
    # remove the older value column
    remove_column :ratings, :value
    # rename the convert_value to value column
    rename_column :ratings, :convert_value, :value
  end
end
