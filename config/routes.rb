Rails.application.routes.draw do
    get "up" => "rails/health#show", as: :rails_health_check

    root "static#home"
    resources :session, only: [:create]

    post 'register', to: 'auth#create'
    post 'login',    to: 'auth#login'
    post 'logout',   to: 'auth#logout'
end
