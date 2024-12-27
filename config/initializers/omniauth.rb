Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    scope: 'email profile',
    prompt: 'select_account',
    access_type: 'offline'
  }
end

# Allow GET requests for OmniAuth
OmniAuth.config.allowed_request_methods = %i[post get]

# Disable state validation (use with caution)
OmniAuth.config.before_callback_phase do |env|
  env['omniauth.strategy'].options[:provider_ignores_state] = true
end

# Enable OmniAuth logging
OmniAuth.config.logger = Rails.logger
