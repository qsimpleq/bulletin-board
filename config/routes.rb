# frozen_string_literal: true

# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  post 'auth/:provider', to: 'web/auth#request', as: :auth_request
  get 'auth/:provider/callback', to: 'web/auth#callback', as: :callback_auth
  delete 'auth/logout', to: 'web/auth#destroy'

  get 'admin', to: 'web/bulletins#index'
  scope 'admin', module: :web do
    resources :bulletins, as: 'admin_bulletins', only: %i[index]
    resources :categories, except: %i[show]
    resources :users
  end

  scope module: :web do
    # Defines the root path route ("/")
    root 'bulletins#index', to: 'bulletins#index'
    resources :bulletins, only: %i[index show new create edit update] do
      member do
        patch :moderate
        patch :publish
        patch :decline
        patch :archive
      end
    end
    resource :profile, to: 'bulletins#index', only: :show
  end
end
