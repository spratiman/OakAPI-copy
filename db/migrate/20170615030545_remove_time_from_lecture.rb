class RemoveTimeFromLecture < ActiveRecord::Migration[5.1]
  def change
    remove_column :lectures, :time, :string
  end
end
