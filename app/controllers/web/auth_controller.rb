# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def request
      auth = request.env['omniauth.auth']

      redirect_to auth.authorize_url
    end

    def callback
      auth = request.env['omniauth.auth']
      user = User.find_by_provider_and_uid(auth) || User.create_with_omniauth(auth)
      session[:user_id] = user.id

      redirect_to root_url, notice: 'Signed in!'
    end
  end
end
