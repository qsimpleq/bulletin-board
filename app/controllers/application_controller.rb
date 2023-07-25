# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  helper_method %i[back_path current_user user_signed_in?]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = user_signed_in? ? t('pundit.default_admin') : t('pundit.default')
    redirect_back(fallback_location: root_path)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user ? true : false
  end

  def authenticate_user!
    return if user_signed_in?

    flash[:error] = t('error.authenticate_user')

    redirect_to root_path
  end

  def back_path(**params)
    params[:action_name] ||= action_name
    params[:controller_name] ||= controller_name

    if %w[new show].include?(params[:action_name])
      url_for(controller: params[:controller_name], action: :index, only_path: true)
    elsif %w[edit update].include?(params[:action_name])
      url_for(controller: params[:controller_name], action: :show, only_path: true)
    else
      params[:default_path] || request.referer
    end
  end
end
