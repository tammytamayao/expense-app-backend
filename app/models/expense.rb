class Expense < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :date, presence: true
    validate :invalid_date

    private

    def invalid_date
      if date.present? && date > Date.today
        errors.add(:date, "Invalid input date")
      end
    end
end
