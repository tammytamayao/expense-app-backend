class Api::ExpensesController < ApplicationController
  before_action :set_user
  before_action :set_expense, only: [ :show, :update, :destroy ]

  # GET /api/expenses
  def index
    per_page = 10
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @expenses = @user.expenses.limit(per_page).offset((page - 1) * per_page)
    total_amount = @user.expenses.sum(:amount)

    render json: {
      expenses: @expenses,
      total_amount: total_amount,
      current_page: page,
      per_page: per_page,
      total_pages: (@user.expenses.count / per_page.to_f).ceil
    }
  end

  # POST /api/expenses
  def create
    @expense = @user.expenses.new(expense_params)
    if @expense.save
      render json: @expense, status: :created
    else
      render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
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
      render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/expenses/:id
  def destroy
    @expense.destroy
    head :no_content
  end

  private

  def set_user
    username = request.headers["Username"]
    @user = User.find_by(username: username)

    render json: { error: "User not found" }, status: :unauthorized unless @user
  end

  def set_expense
    @expense = @user.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:title, :description, :amount, :date)
  end
end
