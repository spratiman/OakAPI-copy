class CreateTerms < ActiveRecord::Migration[5.1]
  def change
    create_table :terms do |t|
      t.references :course, foreign_key: true
      t.string :term

      t.timestamps
    end
  end
end
