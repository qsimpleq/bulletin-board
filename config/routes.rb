# frozen_string_literal: true

# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  post 'auth/:provider', to: 'web/auth#request', as: :auth_request
  get 'auth/:provider/callback', to: 'web/auth#callback', as: :callback_auth
  delete 'auth/logout', to: 'web/auth#destroy'

  scope module: :web do
    root 'bulletins#index'

    get 'admin', to: 'admin/bulletins#index'
    scope '/admin', module: :admin do
      resources :bulletins, only: :index, as: :admin_bulletins
      resources :categories, except: %i[show]
    end

    resources :bulletins, except: %i[destroy] do
      member do
        patch :moderate
        patch :publish
        patch :decline
        patch :archive
      end
    end

    get :profile, to: 'profile#index'
  end
end
