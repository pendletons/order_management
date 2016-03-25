class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :order_date, null: false
      t.decimal :vat_amount, precision: 3, scale: 2, null: false

      t.timestamps null: false
    end
  end
end
