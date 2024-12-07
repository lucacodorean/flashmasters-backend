class Api::V1::RoleController < ApplicationController
  before_action :set_role, only: [:show, :update, :destroy, :create]
  after_action  :verify_authorized

  def index
      authorize current_user

      roles = Role.all
      render json: roles.map {|role| Api::V1::RoleResource.new(role).as_json(include: params[:include] )}, status: 200
  end

  def show
      authorize current_user
      render json: Api::V1::RoleResource.new(@role).as_json(include: "users" ), status: 200
  end

  def create
      authorize current_user

      role = Role.create(role_params)

      if role
          render json: Api::V1::RoleResource.new(role).as_json, status: 201
          return
      end

      render json: {message: "Can't create the role."}, status: 422
  end

  def update
     authorize current_user

     if @role.update(role_params)
       render json: Api::V1::RoleResource.new(@role).as_json, status: 200
       return
     end

     render json: {message: "Can't update the role."}, status: 422

  end

  def destroy
      authorize current_user
      if @role.delete
        render json: {message: "Role deleted."}, status: 204
        return
      end

      render json: {message: "Can't perform the delete."}, status: 422

  end

  private
      def set_role
          @role = Role.find_by(key: params[:key])
      end

      def role_params
          params.permit(:name)
      end
end
