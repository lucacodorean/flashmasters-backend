Rails.application.routes.draw do
    get "up" => "rails/health#show", as: :rails_health_check

    root "static#home"
    resources :session, only: [:create]

    post    'register',     to: 'auth#create',  as: "auth_register"
    post    'login',        to: 'auth#login',   as: "auth_login"
    post    'logout',       to: 'auth#logout',  as: "auth_logout"

    get     'users',        to: 'user#index',   as: "users_index"
    get     'users/:key',   to: 'user#show',    as: "user_show"
    patch   'users/:key',   to: 'user#update',  as: "user_update"
end
