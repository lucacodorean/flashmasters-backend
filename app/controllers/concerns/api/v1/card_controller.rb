class Api::V1::CardController < ApplicationController

  before_action :set_card, only: [:show, :update, :destroy]
  after_action  :verify_authorized

  def index
    cards = Card.all
    authorize current_user

    render json: cards.map { |card| Api::V1::CardResource.new(card).as_json }, status: 200
  end

  def show
    authorize current_user
    render json: Api::V1::CardResource.new(@card).as_json, status: 200
  end

  def create
    authorize current_user

    card = Card.create(card_params)

    if card
      render json: Api::V1::CardResource.new(card).as_json, status: 201
      return
    end

    render json: {message: "Can't perform the creation of the card."}, status: 422
  end

  def update
    authorize current_user

    if @card.update(card_params)
      render json: Api::V1::CardResource.new(@card).as_json, status: 200
      return
    end

    render json: {message: "Can't perform the update."}, status: 422
  end

  def destroy
    authorize current_user

    @card.images.purge

    if @card.delete
      render json: {message: "Card deleted."}, status: 204
      return
    end

    render json: {message: "Can't perform the delete."}, status: 422
  end

  private
  def set_card
    @card = Card.find_by(key: params[:key])
  end

  def card_params
    params.permit(:text, images: [])
  end
end
