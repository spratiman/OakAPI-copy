require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "should not allow course same codes" do
    course = Course.new(code: 'csc373')
    assert_not course.save
  end

  test "should not add course without code" do
    course = Course.new
    assert_not course.save
  end

  test "should add course with code" do
    course = Course.new(code: 'abc100', title: 'Alphabets')
    assert course.save
  end
end
