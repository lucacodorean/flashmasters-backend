class QuestionBuilder

  def self.build_question(text, correct_answer, answers, cards)
    Question.create!(
      text: text,
      answers: answers,
      correct: correct_answer,
      cards: cards
    )
  end
end