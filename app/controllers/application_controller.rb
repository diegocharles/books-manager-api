# :nocov:
class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  before_action :set_default_response_format
  before_action :enforce_snake_case_on_incoming_params!
  before_action :authorize_request

  helper_method  :current_user

  protected

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end

  def set_default_response_format
    request.format = :json unless params[:format]
  end

  def enforce_snake_case_on_incoming_params!
    request.parameters.deep_transform_keys!(&:underscore)
  end

  def unauthenticated!
    response.headers['WWW-Authenticate'] = 'Token realm=Application'
    render json: { error: 'Bad credentials' }, status: 401
  end
end
# :nocov: