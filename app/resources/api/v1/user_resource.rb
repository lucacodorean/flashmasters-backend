class Api::V1::UserResource < Api::Resource
    include Rails.application.routes.url_helpers

    def initialize(user)
        @user = user
    end
    def as_json(options = {})
        response =   {
              type: "users",
              id: @user.key,
              attributes: {
                name: @user.name,
                email: @user.email,
                created_at: @user.created_at,
                updated_at: @user.updated_at,
              },
              relationships: {
              },
              links: {
                parent: ENV["API_URL"] + "/users",
                self: ENV["API_URL"] + "/users/#{@user.key}",
              }
        }

        if include?(:role, options)
            response[:relationships][:role] = Api::V1::RoleResource.new(@user.role).as_json
        end

        return response.as_json(options)
    end

end