class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :order
      t.references :product
      t.integer :quantity, null: false

      t.timestamps null: false

      t.index :order_id
      t.index :product_id
    end
  end
end
