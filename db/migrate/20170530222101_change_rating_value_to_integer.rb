class ChangeRatingValueToInteger < ActiveRecord::Migration[5.1]
  def up
    # create the new column with a temporary name
    add_column :ratings, :convert_value, :integer
    # remove the older value column
    remove_column :ratings, :value
    # rename the convert_value to value column
    rename_column :ratings, :convert_value, :value
  end

  def down
    change_column :ratings, :value, :boolean
  end
end
