class CreateCardsQuestionsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :cards_questions do |t|
        t.references :card,     null: true, foreign_key: true
        t.references :question, null: true, foreign_key: true
    end
  end
end
