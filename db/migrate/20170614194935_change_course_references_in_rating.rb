class ChangeCourseReferencesInRating < ActiveRecord::Migration[5.1]
  def change
    remove_reference :ratings, :course
    add_reference :ratings, :term, foreign_key: true
    add_index :ratings, [:user_id, :term_id, :rating_type], unique: true
  end
end
