class FixExclusionsColumnNameInTerm < ActiveRecord::Migration[5.1]
  def change
    rename_column :terms, :eclusions, :exclusions
  end
end
