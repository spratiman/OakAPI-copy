class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table(:users) do |t|
      ## User Info
      t.string :name
      t.string :nickname
      t.string :image

      t.timestamps
    end
  end
end
