# frozen_string_literal: true

# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#destroy'

    root 'bulletins#index'

    get 'admin', to: 'admin/home#index'
    namespace :admin do
      resources :bulletins, only: :index do
        member do
          patch :archive
          patch :publish
          patch :reject
        end
      end
      resources :categories, except: %i[show]
    end

    resources :bulletins, except: %i[destroy] do
      member do
        patch :archive
        patch :to_moderate, as: :moderate
      end
    end
    get :profile, to: 'profile#index'
  end
end
