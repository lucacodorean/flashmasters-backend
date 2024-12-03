class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.string :neme
      t.string :key

      t.timestamps
    end
  end
end
