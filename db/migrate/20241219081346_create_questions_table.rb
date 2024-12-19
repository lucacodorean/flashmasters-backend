class CreateQuestionsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string  :text
      t.integer :correct
      t.jsonb   :answers, default: {}
      t.string  :key
      t.timestamps
    end
  end
end
