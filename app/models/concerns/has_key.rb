module HasKey
    extend ActiveSupport::Concern

    included do
        before_create :generate_random_key
    end

    def generate_random_key
        self.key = self.class.name[0,3].downcase + '_' + SecureRandom.alphanumeric(20)
    end
end