class Api::V1::BundleController < ApplicationController

  before_action :set_bundle, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: [:buy]

  def index
    bundles = Bundle.all
    authorize bundles

    render json: bundles.map { |bundle| Api::V1::BundleResource.new(bundle).as_json(include: params[:include]) }, status: 200
  end

  def show
    authorize @bundle
    render json: Api::V1::BundleResource.new(@bundle).as_json(include: ["questions", "users"]), status: 200
  end

  def create
    authorize current_user

    bundle_data = bundle_params.except(:questions)
    bundle = Bundle.create(bundle_data)

    if bundle

      if params[:questions]
        questions = Question.where(key: params[:questions])
        bundle.questions = questions
        bundle.save
      end

      stripe_product = Stripe::Product.create(name: bundle.name, description: bundle.description, metadata: {})
      stripe_price   = Stripe::Price.create(product: stripe_product.id, unit_amount: bundle.price, currency: "ron")

      bundle.update(price_id: stripe_price.id, product_id: stripe_product.id)
      render json: Api::V1::BundleResource.new(bundle).as_json, status: 201
      return
    end

    render json: {message: "Can't perform the creation of the bundle."}, status: 422
  end

  def update
    authorize current_user
    bundle_data = bundle_params.except(:questions)


    if @bundle.update(bundle_data)
      if params[:questions] != nil
        questions = Question.where(key: params[:questions])
        @bundle.questions = questions
        @bundle.save
      end

      if params[:price]
        Stripe::Price.update(@bundle.price_id, active: false)
        stripe_price = Stripe::Price.create(product: @bundle.product_id, unit_amount: params[:price], currency: "ron")
        @bundle.update(price_id: stripe_price.id)
      end

      render json: Api::V1::BundleResource.new(@bundle).as_json(include: ["questions", "users"]), status: 200
      return
    end

    render json: {message: "Can't perform the update."}, status: 422
  end

  def destroy
    authorize current_user

    Stripe::Price.update(@bundle.price_id, active: false)
    Stripe::Product.update(@bundle.product_id, active: false)

    if @bundle.delete
      render json: {message: "Bundle deleted."}, status: 204
      return
    end

    render json: {message: "Can't perform the delete."}, status: 422
  end

  def buy
    if session[:user_id] == nil
      render json: {message: "User not logged."}, status: 401
      return
    end

    customer = User.where(id: session[:user_id]).first
    bundle = Bundle.where(key: params[:key]).first

    if customer.has_access_to_bundle?(bundle)
        render json: {message: "Customer already owns this bundle."}, status: 401
        return
    end

    checkout_data = Stripe::Checkout::Session.create(
      customer: customer.customer_id,
      payment_method_types: ['card'],
      invoice_creation: {enabled: true},
      line_items: [{price: bundle.price_id, quantity: 1}],
      mode: 'payment',
      success_url: "#{ENV["FRONT_END_URL"]}/dashboard",
      cancel_url:  "#{ENV["FRONT_END_URL"]}/error",
      client_reference_id: bundle.product_id,
      billing_address_collection: 'required',
      allow_promotion_codes: true,
    )

    render json: { checkout_url: checkout_data.url }
  end

  private

  def set_bundle
    @bundle = Bundle.find_by(key: params[:key])
  end

  def bundle_params
    params.permit(:name, :description, :icon, :price, questions: [])
  end
end
