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
            resources :roles, only: [:create]

            get     'users',        to: 'user#index',       as: "users_index"
            get     'users/:key',   to: 'user#show',        as: "user_show"
            patch   'users/:key',   to: 'user#update',      as: "user_update"
            delete  'users/:key',   to: 'user#destroy',     as: "user_destroy"

            get     'roles',        to: 'role#index',       as: "roles_index"
            get     'roles/:key',   to: 'role#show',        as: "roles_show"
            put     'roles/',       to: 'role#create',      as: "roles_create"
            patch   'roles/:key',   to: 'role#update',      as: "roles_update"
            delete  'roles/:key',   to: 'role#destroy',     as: "roles_destroy"
        end
    end
end
