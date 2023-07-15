# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      auth = request.env['omniauth.auth']

      user = User.find_by_provider_and_uid(auth) || User.create_with_omniauth(auth)
      session[:user_id] = user.id

      redirect_to root_path, notice: 'Signed in!'
    end

    def destroy
      return unless current_user

      session[:user_id] = nil
      redirect_to root_path, notice: 'Logouted!'
    end
  end
end
