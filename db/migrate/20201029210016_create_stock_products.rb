class CreateStockProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_products do |t|
      t.references :product
      t.references :store
      t.integer :quantity

      t.timestamps
    end

    add_index :stock_products, [:product_id, :store_id], unique: true
  end
end
