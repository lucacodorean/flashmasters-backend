module SoftDeletable
    def soft_delete
        update(deleted_at: Time.current)
    end

    def deleted?
        deleted_at.present?
    end
end