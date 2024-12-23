class CreateUserBundlesTable < ActiveRecord::Migration[7.1]
  def change
    create_table :bundles_users do |t|
      t.references :user,   index: true, foreign_key: true
      t.references :bundle, index: true, foreign_key: true
      t.timestamps
    end
  end
end
