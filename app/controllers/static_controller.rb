class StaticController < ApplicationController
    def home
        render json:  { status: "#{ENV['APP_NAME']} API @ #{ENV['APP_DOMAIN']}" }
    end
end
