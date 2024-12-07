class Api::V1::RoleResource < Api::Resource
  include Rails.application.routes.url_helpers

  def initialize(role)
    @role = role
  end

  def as_json(options = {})
    response = {
      type:   "roles",
      id:     @role.key,
      attributes: {
        name:       @role.name,
        created_at: @role.created_at,
        updated_at: @role.updated_at,
      },
      relationships: {},
      links: {
        parent: ENV["API_URL"] + "/roles",
        self:   ENV["API_URL"] + "/roles/#{@role.key}",
      }
    }

    if include?(:users, options)
      response[:relationships][:users] = @role.users.map {|user| Api::V1::UserResource.new(user).as_json}
    end

    response.as_json(options)
  end
end