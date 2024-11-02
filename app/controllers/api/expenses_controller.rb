class Api::ExpensesController < ApplicationController
    before_action :set_expense, only: [ :show, :update, :destroy ]

    # GET /api/expenses
    def index
      @expenses = Expense.all
      render json: @expenses
    end
    # POST /api/expenses
    def create
      @expense = Expense.new(expense_params)
      if @expense.save
        render json: @expense, status: :created
      else
        render json: @expense.errors, status: :unprocessable_entity
      end
    end

    # GET /api/expenses/:id
    def show
      render json: @expense
    end

    # PATCH/PUT /api/expenses/:id
    def update
      if @expense.update(expense_params)
        render json: @expense
      else
        render json: @expense.errors, status: :unprocessable_entity
      end
    end
    # DELETE /api/expenses/:id
    def destroy
      @expense.destroy
      head :no_content
    end

    private

    def set_expense
      @expense = Expense.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:title, :description, :amount, :date)
    end
end
