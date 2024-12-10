class Card < ApplicationRecordApi
  has_many_attached :images, dependent: :destroy
end
