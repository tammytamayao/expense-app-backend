require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save user without username" do
    user = User.new(password: "password")
    assert_not user.save
  end

  test "should not save user with non-unique username" do
    user1 = users(:one)
    user2 = User.new(username: user1.username, password: "newpassword")
    assert_not user2.save
  end

  test "should not save user without password" do
    user = User.new(username: "newuser")
    assert_not user.save
  end

  test "password should be encrypted" do
    user = User.new(username: "encrypteduser", password: "password")
    user.save
    assert_not_equal "password", user.password_digest
  end

  test "should save user with valid username and password" do
    user = User.new(username: "validuser", password: "password")
    assert user.save
  end

  test "should have many expenses" do
    user = users(:one)
    assert_equal user.expenses.count, 1
  end
end
