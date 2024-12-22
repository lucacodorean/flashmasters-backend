class WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET'])

      case event['type']
        when 'payment_intent.succeeded'
          handle_payment_success(event['data']['object'])

        when 'customer.created'
          handle_customer_created(event['data']['object'])

        else
          Rails.logger.info("Unhandled event type: #{event['type']}")

      end

      render json: { message: 'Success' }, status: :ok

      rescue JSON::ParserError => e
        render json: { error: e.message }, status: :bad_request

      rescue Stripe::SignatureVerificationError => e
        render json: { error: e.message }, status: :unauthorized
      end
  end

  private
    def handle_payment_success(payment_intent)
      Rails.logger.info("Payment succeeded for ID: #{payment_intent['id']}")
    end

    def handle_customer_created(customer)
      Rails.logger.info("Customer created: #{customer['id']}")
    end
end
