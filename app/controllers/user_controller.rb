class UserController < ApplicationController

    before_action :set_user, only: [:show, :update]
    after_action  :verify_authorized, except: [:index]

    def index
        users = User.all
        render json: users.map { |user| UserResource.new(user).as_json }, status: 200
    end

    def show
        authorize @user
        render json: UserResource.new(@user).as_json, status: 200
    end

    def update
        authorize @user
        if @user.update(user_params)
            render json: UserResource.new(@user).as_json, status: 201
            return
        end

        render json: {message: "Can't perform the update."}, status: 403
    end

    private
        def set_user
            @user = User.find_by(key: params[:key])
        end

        def user_params
            params.permit(:name, :email, :password, :password_confirmation)
        end
end
