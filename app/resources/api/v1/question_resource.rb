class Api::V1::QuestionResource < Api::Resource

  def initialize(question)
    @question = question
  end

  def as_json(options = {})
    response = {
      type:   "questions",
      id:     @question.key,
      attributes: {
        text:       @question.text,
        correct:    @question.correct,
        answers:    @question.answers,
        created_at: @question.created_at,
        updated_at: @question.updated_at,
      },
      relationships: {},
      links: {
        parent: ENV["API_URL"] + "/questions",
        self:   ENV["API_URL"] + "/questions/#{@question.key}",
      }
    }

    if include?(:cards, options)
      response[:relationships][:cards] = @question.cards.map {|card| Api::V1::CardResource.new(card).as_json() }
    end

    return response.as_json(options)
  end
end