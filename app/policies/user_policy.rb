class UserPolicy < ApplicationPolicy
    def index?
        user.present? && user.admin?
    end

    def show?
        true
    end

    def create?
        true
    end

    def update?
        (user.present? && user == record) || user.admin?
    end

    def destroy?
        (user.present? && user == record) || user.admin?
    end
end
