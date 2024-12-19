class Card < ApplicationRecordApi
  has_many_attached :images, dependent: :destroy
  has_and_belongs_to_many  :questions
end
