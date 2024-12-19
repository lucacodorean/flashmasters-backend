class Api::V1::QuestionController < ApplicationController
  before_action :set_question, only: [:show, :update, :destroy]
  after_action  :verify_authorized

  def index
    questions = Question.all
    authorize current_user

    render json: questions.map { |question| Api::V1::QuestionResource.new(question).as_json(include: params[:include])}, status: 200
  end

  def show
    authorize current_user
    render json: Api::V1::QuestionResource.new(@question).as_json(include: "cards"), status: 200
  end

  def create
    authorize current_user

    question_data = question_params.except(:cards)
    question = Question.create(question_data)

    if params[:cards]
      cards = Card.where(key: params[:cards])
      question.cards = cards
      question.save
    end

    if question
      render json: Api::V1::QuestionResource.new(question).as_json(include: "cards"), status: 201
      return
    end

    render json: {message: "Can't perform the creation of the card."}, status: 422
  end

  def update
    authorize current_user

    question_data = question_params.except(:cards)

    if @question.update(question_data)
      if params[:cards]
        cards = Card.where(key: params[:cards])
        @question.cards = cards
        @question.save
      end

      render json: Api::V1::QuestionResource.new(@question).as_json(include: "cards"), status: 200
      return
    end

    render json: {message: "Can't perform the update."}, status: 422
  end

  def destroy
    authorize current_user

    if @question.delete
      render json: {message: "Question deleted."}, status: 204
      return
    end

    render json: {message: "Can't perform the delete."}, status: 422
  end

  private
  def set_question
    @question = Question.find_by(key: params[:key])
  end

  def question_params
    params.permit(:text,  :correct, answers: {}, cards: [])
  end
end