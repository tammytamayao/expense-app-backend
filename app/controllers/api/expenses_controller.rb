class Api::ExpensesController < ApplicationController
  before_action :set_expense, only: [ :show, :update, :destroy ]

  # GET /api/expenses
  def index
    per_page = 10
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @expenses = Expense.limit(per_page).offset((page - 1) * per_page)
    total_amount = Expense.sum(:amount)

    render json: {
      expenses: @expenses,
      total_amount: total_amount,
      current_page: page,
      per_page: per_page,
      total_pages: (Expense.count / per_page.to_f).ceil
    }
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
