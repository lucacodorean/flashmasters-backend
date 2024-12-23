class Api::V1::BundleResource < Api::Resource
  include Rails.application.routes.url_helpers

  def initialize(bundle)
    @bundle = bundle
  end
  def as_json(options = {})

    response =   {
      type: "bundles",
      id: @bundle.key,
      attributes: {
        name:        @bundle.name,
        description: @bundle.description,
        price:      (@bundle.price / 100),
        price_id:    @bundle.price_id,
        product_id:  @bundle.product_id,
        created_at:  @bundle.created_at,
        updated_at:  @bundle.updated_at,
      },
      relationships: {
      },
      links: {
        parent: ENV["API_URL"] + "/v1/bundles",
        self: ENV["API_URL"] + "/v1/bundles/#{@bundle.key}",
      }
    }

    if include?(:users, options)
      response[:relationships][:users] = @bundle.users.map { |user| Api::V1::UserResource.new(user).as_json }
    end

    if include?(:questions, options)
      response[:relationships][:questions] = @bundle.questions.map { |question| Api::V1::QuestionResource.new(question).as_json }
    end

    return response.as_json(options)
  end

end