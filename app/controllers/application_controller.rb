class ApplicationController < ActionController::API
    include ActionController::Cookies
    include ActionController::RequestForgeryProtection
    include Pundit::Authorization

    protect_from_forgery with: :exception, unless: -> { request.format.json? }
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    private
        def user_not_authorized
            render json: { error: "Unauthorized. Only the administrators can gain access." }, status: :forbidden
        end
end
