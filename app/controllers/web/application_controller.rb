# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    helper_method %i[current_user back_path user_signed_in?]

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
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

    def user_signed_in?
      current_user ? true : false
    end
  end
end
