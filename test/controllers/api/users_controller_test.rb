require "test_helper"

class Api::UsersControllerTest < ActionDispatch::IntegrationTest
  # Setup users for testing from fixtures
  setup do
    @user = users(:one)
    @valid_password = "password"
    @invalid_password = "wrongpassword"
  end

  # Test the "create" action for user registration
  test "should create user" do
    user_params = { user: { username: "new_user", password: @valid_password } }
    post api_users_url, params: user_params
    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "User created successfully", json["message"]
  end

  # Test the "login" action with valid credentials
  test "should login with valid credentials" do
    post api_login_url, params: { username: @user.username, password: @valid_password }
    assert_response :ok
    json = JSON.parse(response.body)
    assert_equal "Login successful", json["message"]
    assert_equal @user.username, json["user"]["username"]
  end

  # Test the "login" action with invalid credentials
  test "should not login with invalid credentials" do
    post api_login_url, params: { username: @user.username, password: @invalid_password }
    assert_response :unauthorized
    json = JSON.parse(response.body)
    assert_equal "Invalid credentials", json["error"]
  end

  # Test the "logout" action
  test "should logout successfully" do
    delete api_logout_url
    assert_response :ok
    json = JSON.parse(response.body)
    assert_equal "Logout successful", json["message"]
  end
end
