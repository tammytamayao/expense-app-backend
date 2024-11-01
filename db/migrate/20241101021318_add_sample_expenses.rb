class AddSampleExpenses < ActiveRecord::Migration[7.2]
  def up
    Expense.create([
      { title: 'Groceries', description: 'Weekly grocery shopping', amount: 150.00 },
      { title: 'Utilities', description: 'Electricity and water bill', amount: 75.50 },
      { title: 'Rent', description: 'Monthly rent payment', amount: 1200.00 }
    ])
  end

  def down
    Expense.where(title: 'Groceries').delete_all
    Expense.where(title: 'Utilities').delete_all
    Expense.where(title: 'Rent').delete_all
  end
end
