class RolePolicy < ApplicationPolicy

  def index?
    user.is_admin?
  end

  def show?
    user.is_admin?
  end

  def create?
    user.is_admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
