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
        parent: ENV["API_URL"] + "/v1/cards",
        self:   ENV["API_URL"] + "/v1/cards/#{@card.key}",
      }
    }

    if include?(:questions, options)
      response[:relationships][:questions] = @card.questions.map { |question| Api::V1::QuestionResource.new(question).as_json }
    end

    response.as_json(options)
  end
end