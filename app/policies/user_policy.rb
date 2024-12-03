class UserPolicy < ApplicationPolicy

    def index?
        !user.nil? && user.is_admin?
    end

    def show?
        user.present?
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
