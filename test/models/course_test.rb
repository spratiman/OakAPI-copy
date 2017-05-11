require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "should_not_allow_course_same_codes" do
    course = Course.new(code: 'csc373')
    assert_not course.save
  end

  test "should_not_add_course_without_code" do
    course = Course.new
    assert_not course.save
  end

  test "should_add_course_with_code" do
    course = Course.new(code: 'abc100', title: 'Alphabets')
    assert course.save
  end
end
