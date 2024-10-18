class ApplicationPolicy
    attr_reader :user, :record

    # Initialize the policy with the user and the record being acted upon
    def initialize(user, record)
        @user = user        # The current logged-in user
        @record = record  # The model instance being accessed/modified
    end

    def index?
        false
    end

    def show?
        false
    end

    def create?
        @user.admin?
    end

    def new?
        create?
    end

    def update?
        @user.admin?
    end

    def edit?
        update?
    end

    def destroy?
        @user.admin?
    end

    # Scope class for handling record collections
    class Scope
        attr_reader :user, :scope

        def initialize(user, scope)
            @user = user
            @scope = scope
        end

        def resolve
            scope.all
        end
    end
end
