class ApplicationController < ActionController::API
  before_action :authenticate_request, except: :authenticate

  private
  def authenticate_request
    token = request.headers['Authorization']
    token = token.remove("Bearer ")
    decoded_token = decode_token(token)
    @current_user = User.find(decoded_token["user_id"]) if decoded_token
  rescue JWT::DecodeError
    render json: { error: 'Invalid token' }, status: :unauthorized
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base).first
  end
end
