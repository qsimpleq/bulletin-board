# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include AuthManager
    include Pundit::Authorization
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    helper_method %i[back_path current_user sign_in signed_in? sign_out table_column_visible?]

    private

    def back_path(**params)
      params[:action_name] ||= action_name
      params[:controller_name] ||= controller_name

      if %w[new show].include?(params[:action_name])
        url_for(controller: params[:controller_name], action: :index, only_path: true)
      elsif %w[edit update].include?(params[:action_name])
        url_for(controller: params[:controller_name], action: :show, only_path: true)
      else
        params[:default_path] || request.referer || request.path
      end
    end

    def table_column_visible?(column, controller = controller_name)
      instance_variable_get("@#{controller.classify.underscore}_columns").include?(column)
    end

    def user_not_authorized(exception)
      error_message = exception.message
      error_message ||= signed_in? && !current_user.admin? ? t('pundit.default_admin') : t('pundit.default')
      flash[:alert] = error_message
      redirect_back(fallback_location: root_path)
    end
  end
end
