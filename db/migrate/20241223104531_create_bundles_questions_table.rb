class CreateBundlesQuestionsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :bundles_questions do |t|
      t.references :bundle,   index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.timestamps
    end
  end
end
