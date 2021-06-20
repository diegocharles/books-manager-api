class ApplicationController < ActionController::API
  include ActionView::Rendering
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    respond_to :json

    before_action :set_default_response_format
    before_action :enforce_snake_case_on_incoming_params!
    before_action :destroy_session
    before_action :authorize_request

    helper_method :current_profile, :current_user

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

    def not_found
      api_error(status: 404, errors: 'Not found')
    end

    def current_profile
      @current_user&.profile
    end

    attr_reader :current_user

    def set_default_response_format
      request.format = :json unless params[:format]
    end

    def enforce_snake_case_on_incoming_params!
      request.parameters.deep_transform_keys!(&:underscore)
    end

    def destroy_session
      request.session_options[:skip] = true
    end

    def unauthenticated!
      response.headers['WWW-Authenticate'] = 'Token realm=Application'
      render json: { error: 'Bad credentials' }, status: 401
    end

    def unauthorized!
      render json: { error: 'not authorized' }, status: 403
    end

    def invalid_resource!(errors = [])
      api_error(status: 422, errors: errors)
    end

    def not_found!
      api_error(status: 404, errors: 'Not found')
    end

    def api_error(status: 500, errors: [])
      unless Rails.env.production?
        puts errors.full_messages if errors.respond_to? :full_messages
      end
      head(status) && return if errors.empty?

      render json: jsonapi_format(errors).to_json, status: status
    end

    def jsonapi_format(errors)
      return errors if errors.is_a? String

      errors_hash = {}
      errors.messages.each do |attribute, error|
        array_hash = []
        error.each do |e|
          array_hash << { attribute: attribute, message: e }
        end
        errors_hash.merge!({ attribute => array_hash })
      end

      errors_hash
    end
  end
end
