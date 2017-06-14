class RemoveUserRefInTerm < ActiveRecord::Migration[5.1]
  def change
    remove_reference :terms, :user
  end
end
