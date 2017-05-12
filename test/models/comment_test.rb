require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should allow multiple comments" do
    comment = Comment.new(user: users(:richard), course: courses(:csc373))
    assert comment.save
  end

  test "should not allow comments without user" do
    comment = Comment.new(course: courses(:csc373))
    assert_not comment.save
  end

  test "should not allow comments without course" do
    comment = Comment.new(user: users(:richard))
    assert_not comment.save
  end

  test "should update body" do
    comment = comments(:one)
    comment.body = "Changed my mind after the results of first term went out..."
    assert comment.save
  end
end
