class ApplicationRecordApi < ApplicationRecord
    include HasKey
    self.abstract_class = true
end
