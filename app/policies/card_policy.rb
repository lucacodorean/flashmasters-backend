class CardPolicy < ApplicationPolicy

  def index?
    user.is_admin?
  end


  # cand adaug conceptul de bundle, sa verific daca userul are acces la bundle-ul din care
  # face parte cardul
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
