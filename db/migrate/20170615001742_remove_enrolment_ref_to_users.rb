class RemoveEnrolmentRefToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_reference :users, :enrolment, foreign_key: true
  end
end
