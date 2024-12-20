class Api::ExpensesController < ApplicationController
  before_action :set_current_user
  before_action :set_expense, only: %i[ show update destroy ]

  # GET /api/expenses
  def index
    @expenses = fetch_expenses
    total_amount = calculate_total_amount
    render json: response_payload(@expenses, total_amount)
  end

  # POST /api/expenses
  def create
    @expense = @user.expenses.new(expense_params)
    if @expense.save
      render json: @expense, status: :created
    else
      render_error(@expense)
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
      render_error(@expense)
    end
  end

  # DELETE /api/expenses/:id
  def destroy
    @expense.destroy
    head :no_content
  end

  private

  def set_current_user
    @user = User.find_by(username: request.headers["Username"])
    render json: { error: "User not found" }, status: :unauthorized unless @user
  end

  def set_expense
    @expense = @user.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:title, :description, :amount, :date)
  end

  def fetch_expenses
    per_page = 10
    page = params[:page].to_i.positive? ? params[:page].to_i : 1
    @user.expenses.order(date: :asc).limit(per_page).offset((page - 1) * per_page)
  end

  def calculate_total_amount
    @user.expenses.sum(:amount)
  end

  def response_payload(expenses, total_amount)
    {
      expenses: expenses,
      total_amount: total_amount,
      current_page: params[:page].to_i.positive? ? params[:page].to_i : 1,
      per_page: 10,
      total_pages: (@user.expenses.count / 10.0).ceil
    }
  end

  def render_error(expense)
    render json: { errors: expense.errors.full_messages }, status: :unprocessable_entity
  end
end
