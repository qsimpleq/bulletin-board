# frozen_string_literal: true

# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  post 'auth/:provider', to: 'web/auth#request', as: :auth_request
  get 'auth/:provider/callback', to: 'web/auth#callback', as: :callback_auth
  delete 'auth/logout', to: 'web/auth#destroy'

  scope module: :web do
    root 'bulletins#index'

    resource :admin, to: 'bulletins#index', only: :show, as: :admin
    scope 'admin' do
      get 'bulletins', to: 'bulletins#index', as: :admin_bulletins, only: %i[show]
      resources :categories, except: %i[show]
    end

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
