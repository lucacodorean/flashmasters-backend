class Api::Auth::AuthController < ApplicationController
    def register
        if User.find_by(email: params['email']) != nil
            render json: { message: "Account already exists." }, status: :unauthorized
            return
        end

        if params['password'] != params['password_confirmation']
              render json: { message: 'Passwords do not match.' }, status: :unprocessable_entity
              return
        end

        user = User.create!(
          email:                 params['email'],
          password:              params['password'],
          password_confirmation: params['password_confirmation'],
          name:                  params['name'],
          role:                  Role.where(key: params["role_id"]).first
        )

        if user
            session[:user_id] = user.id
            render json: Api::V1::UserResource.new(User.find(session[:user_id])).as_json, status: 201
            return
        end

        render json: { message: "Can't register the user." }, status: 422
    end

    def login
        user = User.find_by(email: params['email'])

        if  user == nil
            render json: { message: "User not found"}, status: :unauthorized
            return
        end

        user.authenticate(params[:password])
        session[:user_id] = user.id
        render json: Api::V1::UserResource.new(user).as_json, status: 200
    end

    def logout
        if session[:user_id] == nil
            render json: {message: "No user logged-in."}, status: :unprocessable_entity
            return
        end

        session.delete(:user_id)
        render json: {message: "User has been logged-out."}, status: 200
    end
end