class BundlePolicy < ApplicationPolicy

  def index?
    true
  end

  # User has access to bundle? tbe
  def show?
    user.has_access_to_bundle?(record)
  end

  def create?
    user.is_admin? || user.is_maintainer?
  end

  def update?
    user.is_admin? || user.is_maintainer?
  end

  def destroy?
    user.admin?
  end
end
