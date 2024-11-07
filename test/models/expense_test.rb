require "test_helper"

class ExpenseTest < ActiveSupport::TestCase
  test "should not save expense without title" do
    expense = Expense.new(description: "Test description", amount: 100, date: Date.today, user_id: users(:one).id)
    assert_not expense.save
  end

  test "should not save expense without description" do
    expense = Expense.new(title: "Test title", amount: 100, date: Date.today, user_id: users(:one).id)
    assert_not expense.save
  end

  test "should not save expense without amount" do
    expense = Expense.new(title: "Test title", description: "Test description", date: Date.today, user_id: users(:one).id)
    assert_not expense.save
  end

  test "should not save expense with negative amount" do
    expense = Expense.new(title: "Test title", description: "Test description", amount: -1, date: Date.today, user_id: users(:one).id)
    assert_not expense.save
  end

  test "should not save expense without date" do
    expense = Expense.new(title: "Test title", description: "Test description", amount: 100, user_id: users(:one).id)
    assert_not expense.save
  end

  test "should not save expense with future date" do
    expense = Expense.new(title: "Test title", description: "Test description", amount: 100, date: Date.tomorrow, user_id: users(:one).id)
    assert_not expense.save
  end

  test "should save valid expense" do
    expense = Expense.new(title: "Test title", description: "Test description", amount: 100, date: Date.today, user_id: users(:one).id)
    assert expense.save
  end

  test "should belong to a user" do
    expense = Expense.new(title: "Test title", description: "Test description", amount: 100, date: Date.today, user_id: users(:one).id)
    assert_equal expense.user.username, users(:one).username
  end
end
