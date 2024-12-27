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
            stripe_client = Stripe::Customer.create(name: user.name, email: user.email)
            user.update(customer_id: stripe_client.id)

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

        if !user.authenticate(params[:password])
            render json: { message: "Wrong credentials."}, status: :unauthorized
            return
        end

        session[:user_id] = user.id
        render json: Api::V1::UserResource.new(user).as_json(include: ["role", "bundles"]), status: 200
    end

    def logout
        if session[:user_id] == nil
            render json: {message: "No user logged-in."}, status: :unprocessable_entity
            return
        end

        session.delete(:user_id)
        render json: {message: "User has been logged-out."}, status: 200
    end

    def logged
        render json: {logged: session[:user_id] != nil ? true : false}, status: session[:user_id] != nil ? 200 : 401
    end
end