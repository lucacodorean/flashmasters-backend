class Api::V1::CardResource < Api::Resource
  include Rails.application.routes.url_helpers

  def initialize(card)
    @card = card
  end

  def as_json(options = {})
    response = {
      type:   "cards",
      id:     @card.key,
      attributes: {
        text:       @card.text,
        created_at: @card.created_at,
        updated_at: @card.updated_at,
      },
      relationships: {
        images: @card.images.map { |image| url_for(image) },
      },
      links: {
        parent: ENV["API_URL"] + "/cards",
        self:   ENV["API_URL"] + "/cards/#{@card.key}",
      }
    }

    response.as_json(options)
  end
end