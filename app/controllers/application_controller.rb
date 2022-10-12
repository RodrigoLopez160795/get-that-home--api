class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::Serialization
  before_action :require_login!
  before_action :set_active_storage_current_host

  def set_active_storage_current_host
    p request
    puts "*********************************"
    ActiveStorage::Current.url_options = request.base_url
  end

  def require_login!
    current_user || render_unauthorized("Access denied")
  end

  def current_user
    @current_user ||= authenticate_token
  end

  def render_unauthorized(error_message)
    render json: { errors: error_message }, status: :unauthorized
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

  private

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      User.where(token:).first
    end
  end
end
