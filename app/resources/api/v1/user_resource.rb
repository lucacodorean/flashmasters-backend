class Api::V1::UserResource
    include Rails.application.routes.url_helpers

    def initialize(user)
        @user = user
    end

    def as_json(options = {})
        {
            type:   "users",
            id:     @user.key,
            attributes: {
                name:       @user.name,
                email:      @user.email,
                created_at: @user.created_at,
                updated_at: @user.updated_at,
            },
            relationships: {},
            links: {
                parent: ENV["API_URL"] + "/users",
                self:   ENV["API_URL"] + "/users/#{@user.key}",
            }
        }.as_json(options)
    end
end