class TransactionController < ApplicationController
  before_action :check_params, :initialize_destination_user
  before_action :check_admin_role, only: [:deposit, :withdraw]
  before_action :set_current_user_balance, :check_is_amount_greater_than_sender_balance, only: [:transfer]
  before_action :set_destination_user_balance, :check_is_amount_greater_than_destination_balance, only: [:withdraw]

  def transfer
    ActiveRecord::Base.transaction do
      action = Action.find_by(name: "transfer")
      
      sender_transaction = create_transaction(action: action, user: @current_user, debit: params[:amount])
      transfer = create_transfer(ref_transaction: sender_transaction, recipient: @destination_user, amount: params[:amount])

      recipient_transaction = create_transaction(action: action, user: @destination_user, credit: params[:amount], ref_transaction: sender_transaction)
    end

    render_success("Money transfer completed successfully")
  end

  def deposit
    ActiveRecord::Base.transaction do
      action = Action.find_by(name: "deposit")
      create_transaction(action: action, user: @destination_user, credit: params[:amount])
    end

    render_success("Balance has been credited to the account")
  end

  def withdraw
    ActiveRecord::Base.transaction do
      action = Action.find_by(name: "withdraw")
      create_transaction(action: action, user: @destination_user, debit: params[:amount])
    end

    render_success("Withdrawal request processed successfully.")
  end

  private
  def check_admin_role
    error_messages = ["Only admin can access to this resource"] unless @current_user.role.downcase == "admin"

    render_error(error_messages) if error_messages.present?
  end

  def check_params
    error_messages = []
    error_messages.push("'user_id' params must be present") unless params[:user_id].present?
    error_messages.push("'amount' params must be present") unless params[:amount].present?
    error_messages.push("'amount' params must be more than 0") unless params[:amount].to_f > 0

    render_error(error_messages) if error_messages.present?
  end

  def set_current_user_balance
    @current_user_balance = Balance.lock("FOR SHARE").find_by(user_id: @current_user.id)
  end

  def set_destination_user_balance
    @destination_user_balance = Balance.lock("FOR SHARE").find_by(user_id: params[:user_id])
  end

  def initialize_destination_user
    @destination_user = User.find_by(id: params[:user_id])
    error_messages = ["Destination user is not valid"] unless @destination_user.present?

    render_error(error_messages) if error_messages.present?
  end

  def check_is_amount_greater_than_sender_balance
    render_error("Your balance is insufficient") unless @current_user_balance.amount >= params[:amount].to_f
  end

  def check_is_amount_greater_than_destination_balance
    render_error("Your balance is insufficient") unless @destination_user_balance.amount >= params[:amount].to_f
  end

  def create_transaction(action:, user:, debit: 0, credit: 0, ref_transaction: nil)
    Transaction.create!(user: user, action: action, debit: debit, credit: credit, ref_transaction: ref_transaction)
  end

  def create_transfer(ref_transaction:, recipient:, amount:)
    Transfer.create!(ref_transaction: ref_transaction, recipient: recipient, amount: amount)
  end

  def render_error(error_messages)
    render json: { errors: error_messages }, status: :unprocessable_entity
  end

  def render_success(message)
    render json: { message: message }
  end
end
