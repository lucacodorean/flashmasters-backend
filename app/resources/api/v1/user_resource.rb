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
                description: @user.description,
                uid:         @user.uid,
                provider:    @user.provider == nil ? "APP" : @user.provider,
                avatar:      @user.avatar,
                customer_id: @user.customer_id,
                created_at:  @user.created_at,
                updated_at:  @user.updated_at,
              },
              relationships: {
              },
              links: {
                parent: ENV["API_URL"] + "/v1/users",
                self: ENV["API_URL"] + "/v1/users/#{@user.key}",
              }
        }

        if include?(:role, options)
            response[:relationships][:role] = Api::V1::RoleResource.new(@user.role).as_json
        end

        if include?(:bundles, options)
          response[:relationships][:bundles] = @user.bundles.map { |bundle| Api::V1::BundleResource.new(bundle).as_json }
        end

        return response.as_json(options)
    end

end