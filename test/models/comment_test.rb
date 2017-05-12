require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should allow a comment on course" do
    comment = Comment.new(user: users(:dinesh), course: courses(:csc473))
    assert comment.save
  end

  test "should allow multiple comments" do
    comment = Comment.new(user: users(:richard), course: courses(:csc373))
    assert comment.save
  end

  test "should not allow comment without user" do
    comment = Comment.new(course: courses(:csc373))
    assert_not comment.save
  end

  test "should not allow comment without course" do
    comment = Comment.new(user: users(:richard))
    assert_not comment.save
  end

  test "should update body" do
    comment = comments(:one)
    comment.body = "Changed my mind after the results of first term went out..."
    assert comment.save, "Did not update body of comment"
  end

  test "should allow single reply by different user" do
    parent_comment = Comment.create(
      body: "This is a parent comment.",
      user: users(:gilfoyle),
      course: courses(:csc473)
    )
    child_comment = Comment.new(
      body: "This is a reply.",
      user: users(:richard),
      course: courses(:csc473),
      ancestry: parent_comment.id.to_s()
    )
    assert child_comment.save
  end

  test "should allow single reply by same user" do
    parent_comment = Comment.create(
      body: "This is a parent comment.",
      user: users(:gilfoyle),
      course: courses(:csc473)
    )
    child_comment = Comment.new(
      body: "This is a reply.",
      user: users(:gilfoyle),
      course: courses(:csc473),
      ancestry: parent_comment.id.to_s()
    )
    assert child_comment.save
  end

  test "should allow multiple replies by same user" do
    parent_comment = Comment.create(
      body: "This is a parent comment.",
      user: users(:gilfoyle),
      course: courses(:csc473)
    )
    child_comment1 = Comment.new(
      body: "This is a reply.",
      user: users(:richard),
      course: courses(:csc473),
      ancestry: parent_comment.id.to_s()
    )
    assert child_comment1.save
    child_comment2 = Comment.new(
      body: "I have something to add on.",
      user: users(:richard),
      course: courses(:csc473),
      ancestry: parent_comment.id.to_s()
    )
    assert child_comment2.save
  end

  test "should not allow reply with different course" do
    parent_comment = comments(:one)
    reply = Comment.new(
      body: "This is a reply without a course.",
      user: users(:gilfoyle),
      course: courses(:csc473),
      ancestry: parent_comment.id.to_s()
    )
    assert_not reply.save, "Replied to comment with different course"
  end

  test "should limit comment depth to 5" do
    parent_comment = comments(:one)
    (1..4).each do |i|
      parent_comment = Comment.create(
        body: "This is a reply of depth " + i.to_s(),
        user: users(:gilfoyle),
        course: courses(:csc473),
        ancestry: parent_comment.id.to_s()
      )
    end
    reply = Comment.new(
      body: "This is a reply.",
      user: users(:gilfoyle),
      course: courses(:csc473),
      ancestry: parent_comment.id.to_s()
    )
    assert_not reply.save
  end
end
