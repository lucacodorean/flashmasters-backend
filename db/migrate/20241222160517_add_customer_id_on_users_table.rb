class AddCustomerIdOnUsersTable < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :customer_id, :string
  end
end
