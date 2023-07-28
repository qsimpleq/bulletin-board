# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
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
