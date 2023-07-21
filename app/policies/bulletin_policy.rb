# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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
    user&.id == record.creator_id || user&.admin?
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

  def decline?
    quser&.admin?
  end

  def archive?
    edit?
  end
end

