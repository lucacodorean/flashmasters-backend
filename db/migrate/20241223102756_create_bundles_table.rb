class CreateBundlesTable < ActiveRecord::Migration[7.1]
  def change
    create_table :bundles do |t|
      t.string  :name
      t.string  :description
      t.string  :key
      t.integer :price
      t.string  :price_id
      t.string  :product_id
      t.timestamps
    end
  end
end
