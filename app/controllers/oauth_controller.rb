class OauthController < ApplicationController

    skip_before_action :verify_authenticity_token, only: [:callback]

  def callback
    auth_info = request.env['omniauth.auth']
    puts auth_info['info']['email']

    unless auth_info
      render json: { error: "OmniAuth data missing. Check configuration or request." }, status: :bad_request
      return
    end

    user = User.find_or_create_by(email: auth_info['info']['email']) do |user|
          user.name = auth_info['info']['name']
          user.email = auth_info['info']['email']
          user.password = auth_info['info']['email']
          user.avatar = auth_info['info']['image']
          user.uid = auth_info['uid']
          user.provider = "google_oauth2"
          user.role = Role.find_by(name: "Student")
          user.description = "Logged via Google."
    end

    user.save!

      unless user.customer_id
        stripe_client = Stripe::Customer.create(name: user.name, email: user.email)
        user.update(customer_id: stripe_client.id)
      end

      session[:user_id] = user.id
      redirect_to "#{ENV['FRONT_END_URL']}/google/?user=#{CGI.escape(user.key)}"
      return
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity

  end

end