# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    user.present?
  end

  def create?
    new?
  end

  def edit?
    user.present? && (user&.id == record.user_id || user&.admin?)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def to_moderate?
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
