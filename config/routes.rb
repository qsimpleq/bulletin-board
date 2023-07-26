# frozen_string_literal: true

# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  post 'auth/:provider', to: 'web/auth#request', as: :auth_request
  get 'auth/:provider/callback', to: 'web/auth#callback', as: :callback_auth
  delete 'auth/logout', to: 'web/auth#destroy'

  scope module: :web do
    root 'bulletins#index'

    get 'admin', to: 'admin/bulletins#index'
    namespace :admin do
      resources :bulletins, only: :index do
        member do
          patch :archive
          patch :moderate
          patch :publish
          patch :reject
        end
      end
      resources :categories, except: %i[show]
    end

    resources :bulletins, except: %i[destroy] do
      member do
        patch :archive, to: 'admin/bulletins#archive'
      end
    end
    get :profile, to: 'profile#index'
  end
end
