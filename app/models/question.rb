class Question < ApplicationRecordApi
    has_and_belongs_to_many :cards
    has_and_belongs_to_many :bundles
end
