class RemoveEnrolmentRefToTerms < ActiveRecord::Migration[5.1]
  def change
    remove_reference :terms, :enrolment, foreign_key: true
  end
end
