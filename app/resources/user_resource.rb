class UserResource
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
                parent: users_index_url(host: ENV["APP_DOMAIN"], port: ENV["APP_PORT"]),
                self:   user_show_url(@user.key, host: ENV["APP_DOMAIN"], port: ENV["APP_PORT"]),
            }
        }.as_json(options)
    end
end