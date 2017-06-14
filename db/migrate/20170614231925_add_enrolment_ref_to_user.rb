class AddEnrolmentRefToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :enrolment, foreign_key: true
  end
end
