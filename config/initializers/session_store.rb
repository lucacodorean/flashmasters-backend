if Rails.env == "production"
    Rails.application.config.session_store :cookie_store,
                                           key: ENV['APP_NAME'],
                                           domanin: ENV['APP_DOMAIN'],
                                           httponly: true
else
    Rails.application.config.session_store :cookie_store, key: ENV['APP_NAME'], httponly: true
end