class AddEnrolmentRefToTerms < ActiveRecord::Migration[5.1]
  def change
    add_reference :terms, :enrolment, foreign_key: true
  end
end
