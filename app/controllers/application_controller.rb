class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::Serialization
  before_action :set_host_for_local_storage
  before_action :require_login!

  def require_login!
    current_user || render_unauthorized("Access denied")
  end

  def current_user
    @current_user ||= authenticate_token
  end

  def render_unauthorized(error_message)
    render json: { errors: error_message }, status: :unauthorized
  end

  private

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      User.where(token:).first
    end
  end

  def set_host_for_local_storage
     ActiveStorage::Current.host = request.base_url if Rails.application.config.active_storage.service == :local
 end
end
