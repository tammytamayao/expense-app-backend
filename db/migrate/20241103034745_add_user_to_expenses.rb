class AddUserToExpenses < ActiveRecord::Migration[7.2]
  def change
    add_reference :expenses, :user, null: false, foreign_key: true
  end
end
