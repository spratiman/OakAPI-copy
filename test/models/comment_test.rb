require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  # ----------------------------------------------------------------------
  # Testing for the ability to create new comments.
  # ----------------------------------------------------------------------

  test "should allow a comment on course" do
    comment = Comment.new(body: "this is a comment", user: users(:dinesh), course: courses(:csc473))
    assert comment.save
  end

  test "should allow multiple comments by same user on course" do
    comment = Comment.new(body: "great course", user: users(:richard), course: courses(:csc373))
    assert comment.save
  end

  test "should not allow comments without body" do
    comment = Comment.new(course: courses(:csc373), user: users(:richard))
    assert_not comment.save
  end

  test "should not allow comment without user" do
    comment = Comment.new(body: "this is a comment", course: courses(:csc373))
    assert_not comment.save
  end

  test "should not allow comment without course" do
    comment = Comment.new(body: "this is a comment", user: users(:richard))
    assert_not comment.save
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to update existing comments.
  # ----------------------------------------------------------------------

  test "should update body" do
    comment = comments(:one)
    comment.body = "Changed my mind after the results of first term went out..."
    assert comment.save!, "Did not update body of comment"
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to reply to comments in different scenarios.
  # ----------------------------------------------------------------------

  test "should allow single reply by different user" do
    parent_comment = Comment.create!(
      body: "This is a parent comment.",
      user: users(:gilfoyle),
      course: courses(:csc473)
    )
    child_comment = Comment.new(
      body: "This is a reply.",
      user: users(:richard),
      course: courses(:csc473),
      parent: parent_comment
    )
    assert child_comment.save
  end

  test "should allow single reply by same user" do
    parent_comment = Comment.create!(
      body: "This is a parent comment.",
      user: users(:gilfoyle),
      course: courses(:csc473)
    )
    child_comment = Comment.new(
      body: "This is a reply.",
      user: users(:gilfoyle),
      course: courses(:csc473),
      parent: parent_comment
    )
    assert child_comment.save
  end

  test "should allow multiple replies by same user" do
    parent_comment = Comment.create!(
      body: "This is a parent comment.",
      user: users(:gilfoyle),
      course: courses(:csc473)
    )
    child_comment1 = Comment.new(
      body: "This is a reply.",
      user: users(:richard),
      course: courses(:csc473),
      parent: parent_comment
    )
    assert child_comment1.save
    child_comment2 = Comment.new(
      body: "I have something to add on.",
      user: users(:richard),
      course: courses(:csc473),
      parent: parent_comment
    )
    assert child_comment2.save
  end

  test "should not allow reply with different course" do
    parent_comment = comments(:one)
    reply = Comment.new(
      body: "This is a reply without a course.",
      user: users(:gilfoyle),
      course: courses(:csc473),
      parent: parent_comment
    )
    assert_not reply.save, "Replied to comment with different course"
  end

  test "should limit reply depth to 5" do
    parent_comment = comments(:one)
    (1..5).each do |i|
      parent_comment = Comment.new(
        body: "This is a reply of depth " + i.to_s(),
        user: users(:gilfoyle),
        course: courses(:csc373),
        parent: parent_comment
      )
      assert parent_comment.save!
    end
    reply = Comment.new(
      body: "This is a reply.",
      user: users(:gilfoyle),
      course: courses(:csc373),
      parent: parent_comment
    )
    assert_not reply.save, "Added reply of depth greater than 5"
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to delete comments in different ancestry
  # situations.
  # ----------------------------------------------------------------------

  test "destroy should delete comment, given root and no children" do
    comment = comments(:one)
    assert comment.destroy
  end

  test "destroy should decrease count, given root and no children" do
    comment = comments(:one)
    assert_difference 'Comment.count', -1 do
      comment.destroy
    end
  end

  test "destroy should delete comment, given leaf and not root" do
    comment = comments(:three)
    comment.destroy
  end

  test "destroy should decrease count, given leaf and not root" do
    comment = comments(:three)
    assert_difference 'Comment.count', -1 do
      comment.destroy
    end
  end

  test "destroy should raise error, given has children" do
    comment = comments(:two)
    assert_raises(Ancestry::AncestryException) do
      comment.destroy
    end
  end

  test "should_not_allow_empty_body_change" do
    comment = comments(:one)
    comment.body = ""
    assert_not comment.save
  end
end
