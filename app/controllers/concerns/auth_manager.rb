# frozen_string_literal: true

module AuthManager
  include I18n

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def reset_session
    @current_user = nil
    session[:user_id] = nil
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    reset_session
  end

  def signed_in?
    session[:user_id].present? && current_user.present?
  end

  def auth_user!
    if current_user.blank?
      sign_out
      raise Pundit::NotAuthorizedError, I18n.t('pundit.default')
    end
  end

  def auth_user_admin!
    unless current_user&.admin?
      sign_out
      raise Pundit::NotAuthorizedError, I18n.t('pundit.default_admin')
    end
  end
end
