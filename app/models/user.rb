class User < ApplicationRecordApi
    has_secure_password
    validates_presence_of :email
    def is_admin?
        admin
    end

    belongs_to :role
end
