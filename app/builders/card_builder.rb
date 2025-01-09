class CardBuilder
  def self.build_card(text, images = nil)
    Card.create!(text: text, images: images)
  end
end