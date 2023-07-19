# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return unless user&.admin?

      scope.all
    end
  end

  def index?
    user&.admin?
  end

  def new?
    user&.admin?
  end

  def create?
    user&.admin?
  end

  def edit?
    user&.admin?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
