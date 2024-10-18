class UserResource
    def initialize(user)
        @user = user
    end

    def as_json(options = {})
        {
            type:   "users",
            id:     @user.key,
            attributes: {
                name:   @user.name,
                email:  @user.email,
                created_at: @user.created_at,
                updated_at: @user.updated_at,
            },
            relationships: {},
            links: {}
        }.as_json(options)
    end
end