# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      auth = request.env['omniauth.auth']
      auth_params = build_auth_params(auth)
      user = User.find_or_initialize_by(email: auth_params[:email], uid: auth_params[:uid])
      user.admin = auth_params[:admin]
      user.name = auth_params[:name]
      user.provider = auth_params[:provider]
      if user.save
        sign_in user
        redirect_to root_path, notice: t('action.sign_in')
      else
        redirect_to root_path, alert: t('.error')
      end
    end

    def destroy
      sign_out

      redirect_back_or_to root_path, notice: t('action.sign_out')
    end

    private

    def build_auth_params(auth)
      {
        admin: true,
        email: auth['info']['email'],
        name: auth['info']['name'],
        provider: auth['provider'],
        uid: auth['uid']
      }
    end
  end
end
