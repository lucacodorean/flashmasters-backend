class Api::Auth::GoogleController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:redirect]

  def redirect
    strategy = OmniAuth::Strategies::GoogleOauth2.new(
      nil,
      ENV['GOOGLE_CLIENT_ID'],
      ENV['GOOGLE_CLIENT_SECRET'],
      {
        scope: 'email profile',
        prompt: 'select_account',
        access_type: 'offline'
      }
    )

    redirect_url = strategy.options.client_options[:authorize_url] +
      "?client_id=#{ENV['GOOGLE_CLIENT_ID']}" +
      "&redirect_uri=#{callback_url}" +
      "&response_type=code" +
      "&scope=#{strategy.options.scope}" +
      "&access_type=#{strategy.options.access_type}" +
      "&prompt=#{strategy.options.prompt}"

      Rails.logger.debug "State Parameter Sent: #{session['omniauth.state']}"
      Rails.logger.debug "State Parameter Received: #{params[:state]}"


    render json: {message: redirect_url}
  end

  def callback_url
    "#{request.base_url}/auth/google_oauth2/callback"
  end

end