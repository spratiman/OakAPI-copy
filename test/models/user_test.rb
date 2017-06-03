require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not allow multiple users" do
    user = User.new('email': 'erlich@piedpiper.io', 'name': 'Jian Yang', 'nickname': 'Jian', password: 'imarich')
    assert_raises(ActiveRecord::RecordInvalid) do
      user.save!
    end
  end

  test "should not allow user without all info" do
    user = User.new('email': 'monica@piedpiper.io', 'name': 'Jian Yang', 'nickname': 'Jian')
    assert_not user.save
  end

  test "should allow user with all info" do
    user = User.new(email: 'jared@piedpiper.io', name: 'Donald Dunn', nickname: 'Jared', password: 'richardislove')
    assert user.save
  end

  test "should update user" do
    user = users(:richard)
    user.name = 'Monica Hall'
    user.nickname = 'Monica'
    user.email = "monica@piedpiper.io"
    assert user.save
  end

  test "should not update user email to be someone existing" do
    user = users(:richard)
    user.email = 'erlich@piedpiper.io'
    assert_raises(ActiveRecord::RecordInvalid) do
      user.save!
    end
  end
end
