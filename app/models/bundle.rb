class Bundle < ApplicationRecordApi
  has_and_belongs_to_many :questions
  has_and_belongs_to_many :users
end
