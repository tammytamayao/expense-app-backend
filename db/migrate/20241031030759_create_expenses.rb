class CreateExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.string :title
      t.string :description
      t.decimal :amount

      t.timestamps
    end
  end
end
