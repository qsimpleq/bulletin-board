# frozen_string_literal: true

module AuthManager
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def reset_session
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
    raise Pundit::NotAuthorizedError, t('pundit.default') if current_user.blank?
  end

  def auth_user_admin!
    raise Pundit::NotAuthorizedError, t('pundit.default_admin') unless current_user&.admin?
  end
end
