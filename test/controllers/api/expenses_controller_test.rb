require 'test_helper'

class Api::ExpensesControllerTest < ActionDispatch::IntegrationTest
  # Setup users for testing
  setup do
    @user_one = users(:one)
    @user_two = users(:two)
    @expense_one = expenses(:one)
  end

  # Test 'index' action
  test "should get expenses" do
    get api_expenses_url, headers: { Username: @user_one.username }
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal @user_one.id, json['expenses'][0]['user_id']
  end

  # Test 'create' action
  test "should create expense" do
    expense_params = { expense: { title: 'New Title', description: 'New Description', amount: 10.25, date: '2024-11-07' } }
    post api_expenses_url, params: expense_params, headers: { Username: @user_one.username }
    assert_response :created
    json = JSON.parse(response.body)
    assert_equal 'New Title', json['title']
    assert_equal @user_one.id, json['user_id']
  end

  # Test 'show' action
  test "should show expense" do
    get api_expense_url(@expense_one), headers: { Username: @user_one.username }
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal @expense_one.title, json['title']
  end

  # Test 'update' action
  test "should update expense" do
    patch api_expense_url(@expense_one), params: { expense: { title: 'Updated Title' } }, headers: { Username: @user_one.username }
    assert_response :success
    @expense_one.reload
    assert_equal 'Updated Title', @expense_one.title
  end

  # Test 'destroy' action
  test "should destroy expense" do
    assert_difference('Expense.count', -1) do
      delete api_expense_url(@expense_one), headers: { Username: @user_one.username }
    end
    assert_response :no_content
  end
end
