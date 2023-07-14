# frozen_string_literal: true

# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  post 'auth/:provider', to: 'web/auth#request', as: :auth_request
  get 'auth/:provider/callback', to: 'web/auth#callback', as: :callback_auth

  scope module: :web do
    # Defines the root path route ("/")
    root 'categories#new'
    resources :categories
  end
end
