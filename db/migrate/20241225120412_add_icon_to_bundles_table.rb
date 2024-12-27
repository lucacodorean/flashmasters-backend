class AddIconToBundlesTable < ActiveRecord::Migration[7.1]
  def change
    add_column :bundles, :icon, :string
    add_column :bundles, :hours, :integer
  end
end
