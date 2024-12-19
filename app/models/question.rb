class Question < ApplicationRecordApi
    has_and_belongs_to_many :cards
end
