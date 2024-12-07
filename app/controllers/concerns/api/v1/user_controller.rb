class Api::V1::UserController < ApplicationController

    before_action :set_user, only: [:show, :update, :destroy]
    after_action  :verify_authorized

    def index
        users =  User.all
        authorize users

        render json: users.map { |user| Api::V1::UserResource.new(user).as_json(include: params[:include]) }, status: 200
    end

    def show
        authorize @user
        render json: Api::V1::UserResource.new(@user).as_json(include: "role"), status: 200
    end

    def update
        authorize @user

        @user.role = Role.find_by(key: params[:role_id]) if params[:role_id].present?

        if @user.update(user_params)
            render json: Api::V1::UserResource.new(@user).as_json(include: "role"), status: 200
            return
        end

        render json: {message: "Can't perform the update."}, status: 422
    end

    def destroy
        authorize @user
        if @user.delete
            render json: {message: "User deleted."}, status: 204
            return
        end

        render json: {message: "Can't perform the delete."}, status: 422
    end

    private
        def set_user
            @user = User.find_by(key: params[:key])
        end

        def user_params
            params.permit(:name, :email, :password, :password_confirmation, :role)
        end
end
