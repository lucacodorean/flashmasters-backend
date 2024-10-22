Rails.application.routes.draw do
    get "up" => "rails/health#show", as: :rails_health_check

    root "static#home"
    resources :session, only: [:create]
    namespace :api do
        namespace :auth do
            post    'register',     to: 'auth#register',    as: "auth_register"
            post    'login',        to: 'auth#login',       as: "auth_login"
            post    'logout',       to: 'auth#logout',      as: "auth_logout"
        end

        namespace :v1 do
            resources :users, only: [:create]

            get     'users',        to: 'user#index',       as: "users_index"
            get     'users/:key',   to: 'user#show',        as: "user_show"
            patch   'users/:key',   to: 'user#update',      as: "user_update"
        end
    end
end
