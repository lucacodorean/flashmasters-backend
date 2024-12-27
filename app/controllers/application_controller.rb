class ApplicationController < ActionController::API
    include ActionController::Cookies
    include ActionController::RequestForgeryProtection
    include Pundit::Authorization

    protect_from_forgery with: :exception, unless: -> { request.format.json? } # poate trb comentat unless
     skip_before_action :verify_authenticity_token, if: -> { request.path.start_with?('/auth') }
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    before_action :set_csrf_cookie
    before_action :set_csrf_token_header

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def test_csrf
        render json: {
          csrf_token: form_authenticity_token,
          csrf_cookie: cookies['CSRF-TOKEN'],
          csrf_header: response.headers['X-CSRF-Token']
        }
    end

    private
        def user_not_authorized
            render json: { error: "Unauthorized. Only the administrators can gain access." }, status: :forbidden
        end

        def set_csrf_cookie
            unless request.path.start_with?('/api/auth')
                token = form_authenticity_token
                Rails.logger.info "Generated CSRF Token: #{token}"
                cookies['CSRF-TOKEN'] = token if protect_against_forgery?
            end
        end

        def set_csrf_token_header
            unless request.path.start_with?('/api/auth')
                token = form_authenticity_token
                Rails.logger.info "Setting CSRF Token in Header: #{token}"
                response.set_header('X-CSRF-Token', token) if protect_against_forgery?
            end
        end
end
