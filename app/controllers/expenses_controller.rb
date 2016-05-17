# Expenses resources
class ExpensesController < ApplicationController
  before_action :load_budget, only: %i(show create update)
  before_action :load_expense, only: %i(show update)

  # Index is special: it could either render all user's expenses
  # with all specified filters applied, or it could render just
  # expenses within a specific budget.
  def index
    @expenses = find_expenses.all
    render json: @expenses
  end

  def show
    render json: @expense, status: :ok
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.budget = @budget

    status = @expense.save ? :ok : :unprocessable_entity
    render json: @expense, status: status
  end

  def update
    status = @expense.update_attributes(expense_params) ? :ok : :unprocessable_entity
    render json: @expense, status: status
  end

  def destroy
    @expense = find_expenses.where(id: params[:id]).first

    if @expense
      @expense.destroy
      render json: @expense, status: :ok
    else
      head :not_found
    end
  end

  private

  def load_budget
    @budget = current_user.budgets.find(params[:budget_id])
  end

  def load_expense
    @expense = @budget.expenses.find(params[:id])
  end

  def find_expenses
    expenses = current_user.expenses.order(created_at: :desc)
    expenses = expenses.where(budget_id: params[:budget_id]) if params[:budget_id]


    if params[:week]
      week = params[:week].to_i
      time_service = TimeService.new(current_user)

      week_start_time = time_service.week_start_time
      week_end_time = time_service.week_end_time

      start_time = week_start_time - week.weeks
      end_time = week_end_time - week.weeks

      expenses = expenses.where('expenses.created_at between ? and ?', start_time, end_time)
    end

    expenses
  end

  def expense_params
    params.require(:expense).permit(:amount, :comment)
  end
end
