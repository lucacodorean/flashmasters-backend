class CreateCardsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :text
      t.string :key
      t.timestamps
    end
  end
end
