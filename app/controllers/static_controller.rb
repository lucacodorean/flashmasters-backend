class StaticController < ApplicationController
    def home
        render json: {status: "flashmasters API @ " + ENV['APP_DOMAIN']}
    end
end
