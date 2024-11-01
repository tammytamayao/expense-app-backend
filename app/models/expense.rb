class Expense < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
