class UserController < ApplicationController
  def all
    users = User.order(:id)

    render json: { users: users }
  end

  def create
    errors = []
    errors.push("Name parameter must be present") unless params[:name].present?
    errors.push("Email parameter must be present") unless params[:email].present?
    errors.push("Password parameter must be present") unless params[:password].present?
    
    render_errors and return if errors.present?

    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )

    render_errors(user.errors.full_messages) and return unless user.save

    render json: { user: user }
  end

  private
  def render_errors(errors)
    render json: { errors: errors }
  end
end
