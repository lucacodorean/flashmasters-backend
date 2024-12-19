Rails.application.routes.draw do
  resources :question_resources
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
            resources :cards, only: [:create]


            get     'users',        to: 'user#index',       as: "users_index"
            get     'users/:key',   to: 'user#show',        as: "user_show"
            patch   'users/:key',   to: 'user#update',      as: "user_update"
            delete  'users/:key',   to: 'user#destroy',     as: "user_destroy"

            get     'roles',        to: 'role#index',       as: "roles_index"
            get     'roles/:key',   to: 'role#show',        as: "roles_show"
            put     'roles/',       to: 'role#create',      as: "roles_create"
            patch   'roles/:key',   to: 'role#update',      as: "roles_update"
            delete  'roles/:key',   to: 'role#destroy',     as: "roles_destroy"

            get     'cards',        to: 'card#index',       as: "cards_index"
            get     'cards/:key',   to: 'card#show',        as: "cards_show"
            put     'cards/',       to: 'card#create',      as: "cards_create"
            patch   'cards/:key',   to: 'card#update',      as: "cards_update"
            delete  'cards/:key',   to: 'card#destroy',     as: "cards_destroy"

            get     'questions',        to: 'question#index',       as: "questions_index"
            get     'questions/:key',   to: 'question#show',        as: "questions_show"
            put     'questions/',       to: 'question#create',      as: "questions_create"
            patch   'questions/:key',   to: 'question#update',      as: "questions_update"
            delete  'questions/:key',   to: 'question#destroy',     as: "questions_destroy"
        end
    end
end
