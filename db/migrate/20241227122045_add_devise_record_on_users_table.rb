class AddDeviseRecordOnUsersTable < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :uid,      :string
    add_column :users, :provider, :string
    add_column :users, :avatar,   :string
  end
end
