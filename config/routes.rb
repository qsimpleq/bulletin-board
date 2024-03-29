# frozen_string_literal: true

# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#destroy'

    namespace :admin do
      root 'home#index'
      resources :bulletins, only: :index do
        member do
          patch :archive
          patch :publish
          patch :reject
        end
      end
      resources :categories, only: %i[index new create edit update destroy]
    end

    resources :bulletins, only: %i[index new create edit update show] do
      member do
        patch :archive
        patch :to_moderate, as: :moderate
      end
    end

    resource :profile, only: :show
  end
end
