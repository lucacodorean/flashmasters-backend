class User < ApplicationRecordApi
    has_secure_password
    validates_presence_of :email

    def is_admin
        admin ? true : false
    end
end
