class QuestionPolicy < ApplicationPolicy

  def index?
    user.is_admin? || user.is_maintainer?
  end

  # cand adaug conceptul de bundle, sa verific daca userul are acces la bundle-ul din care
  # face parte intrebarea
  def show?
    user.is_admin? || user.is_maintainer?
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
