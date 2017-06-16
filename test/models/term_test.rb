require 'test_helper'

class TermTest < ActiveSupport::TestCase
  test "should not allow term without course" do
    term = Term.new(term: terms(:fall))
    assert_not term.save
  end

  test "should add term with information" do
    term = Term.new(course: courses(:csc373), term: terms(:fall))
    assert term.save
  end
end
