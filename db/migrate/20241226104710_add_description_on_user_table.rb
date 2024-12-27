class AddDescriptionOnUserTable < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :description, :string
    add_column :users, :icon, :string
  end
end
