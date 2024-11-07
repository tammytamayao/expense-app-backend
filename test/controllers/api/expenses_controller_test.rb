require "test_helper"

class Api::ExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @valid_headers = { "Username" => @user.username }
    @expense = expenses(:one)
  end

  test "should not get expenses index without authorization" do
    get api_expenses_url
    assert_response :unauthorized
    json = JSON.parse(response.body)
    assert_equal "User not found", json["error"]
  end

  test "should not get expenses index with invalid username in headers" do
    invalid_headers = { "Username" => "invaliduser" }
    get api_expenses_url, headers: invalid_headers
    assert_response :unauthorized
    json = JSON.parse(response.body)
    assert_equal "User not found", json["error"]
  end

  test "should not show expense without authorization" do
    get api_expense_url(@expense), headers: {}
    assert_response :unauthorized
    json = JSON.parse(response.body)
    assert_equal "User not found", json["error"]
  end

  test "should not create expense without authorization" do
    expense_params = { expense: { title: "Test Expense", description: "Test Description", amount: 10.0, date: Date.today } }
    post api_expenses_url, params: expense_params
    assert_response :unauthorized
    json = JSON.parse(response.body)
    assert_equal "User not found", json["error"]
  end

  test "should not update expense without authorization" do
    expense_params = { expense: { title: "Updated Expense Title" } }
    patch api_expense_url(@expense), params: expense_params, headers: {}
    assert_response :unauthorized
    json = JSON.parse(response.body)
    assert_equal "User not found", json["error"]
  end

  test "should not destroy expense without authorization" do
    delete api_expense_url(@expense), headers: {}
    assert_response :unauthorized
    json = JSON.parse(response.body)
    assert_equal "User not found", json["error"]
  end

  test "should get expenses index" do
    get api_expenses_url, headers: @valid_headers
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal 1, json["expenses"].length
  end

  test "should create expense" do
    expense_params = { expense: { title: "New Expense", description: "New description", amount: 25.0, date: Date.today } }
    assert_difference("@user.expenses.count", 1) do
      post api_expenses_url, params: expense_params, headers: @valid_headers
    end
    assert_response :created
  end

  test "should show expense" do
    get api_expense_url(@expense), headers: @valid_headers
    assert_response :success
  end

  test "should update expense" do
    expense_params = { expense: { title: "Updated Title" } }
    patch api_expense_url(@expense), params: expense_params, headers: @valid_headers
    assert_response :success
    @expense.reload
    assert_equal "Updated Title", @expense.title
  end

  test "should destroy expense" do
    assert_difference("@user.expenses.count", -1) do
      delete api_expense_url(@expense), headers: @valid_headers
    end
    assert_response :no_content
  end
end
