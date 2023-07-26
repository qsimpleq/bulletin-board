# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  attr_accessor :options

  class Scope < Scope
    attr_accessor :options

    def resolve
      base_scope = scope.includes(:user, :category)
      opt = self&.options

      return base_scope.published if opt.nil? || (opt.any? && ['/', opt[:bulletins_path]].include?(opt[:current_path]))

      resolve_auth_routes(base_scope, opt)
    end

    private

    def resolve_auth_routes(base_scope, opt)
      raise Pundit::NotAuthorizedError if user.nil? || !user.admin?

      case opt[:current_path]
      when opt[:admin_path] then base_scope.under_moderation
      when opt[:admin_bulletins_path] then base_scope
      else base_scope.created_by(user)
      end
    end
  end

  def show?
    true
  end

  def new?
    user
  end

  def create?
    user
  end

  def edit?
    user&.id == record.user_id || user&.admin?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def moderate?
    edit?
  end

  def publish?
    user&.admin?
  end

  def reject?
    user&.admin?
  end

  def archive?
    edit?
  end
end
