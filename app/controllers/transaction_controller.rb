class TransactionController < ApplicationController
  def transfer

  end

  def deposit
    ActiveRecord::Base.transaction do
      check_params(params) and return
      set_action("deposit")
      create_transaction(credit: params[:amount])
      find_balance
      sync_balance(params[:amount]) and return
    end

    render_success("The funds have been successfully deposited into your account.")
  end

  def withdraw
    ActiveRecord::Base.transaction do
      check_params(params) and return
      find_balance
      check_withdraw_condition(params[:amount]) and return
      set_action("withdraw")
      create_transaction(debit: params[:amount])
      sync_balance(params[:amount]) and return
    end

    render_success("The funds have been successfully withdrawn from your account.")
  end

  private
  def check_params(params)
    error_messages = []
    error_messages.push("'user_id' params must be present") unless params[:user_id].present?
    error_messages.push("'amount' params must be present") unless params[:amount].present?
    error_messages.push("'amount' params must be more than 0") unless params[:amount].to_f > 0

    render_error(error_messages) if error_messages.present?
  end

  def set_action(name)
    @action = Action.find_by(name: name)
  end

  def check_withdraw_condition(withdraw_amount)
    render_error("Your balance is insufficient") unless @balance.present? && @balance.amount >= withdraw_amount.to_f
  end

  def create_transaction(debit: 0, credit: 0)
    Transaction.create!(user: @current_user, action: @action, debit: debit, credit: credit)
  end

  def find_balance
    @balance = Balance.lock("FOR SHARE").find_by(user: @current_user)
  end

  def sync_balance(amount)
    @balance.amount += amount.to_f if @action.name == "deposit"
    @balance.amount -= amount.to_f if @action.name == "withdraw"
    
    render_error(@balance.errors.full_messages) unless @balance.save
  end

  def render_error(error_messages)
    render json: { errors: error_messages }, status: :unprocessable_entity
  end

  def render_success(message)
    render json: { message: message }
  end
end
