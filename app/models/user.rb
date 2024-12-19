class User < ApplicationRecordApi
    has_secure_password
    validates_presence_of :email
    belongs_to :role
    def is_admin?
        admin
    end

    def is_maintainer?
        role.id == 1
    end
end
