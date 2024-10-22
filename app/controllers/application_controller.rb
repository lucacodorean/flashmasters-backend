class ApplicationController < ActionController::API
    include ActionController::Cookies
    include ActionController::RequestForgeryProtection
    include Pundit::Authorization

    protect_from_forgery with: :exception, unless: -> { request.format.json? }

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
