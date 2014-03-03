class CreateStockLogs < ActiveRecord::Migration
  def change
    create_table :stock_logs do |t|
      t.references :device
      t.integer :in_area_id
      t.integer :out_area_id
      t.integer :amount
      t.datetime :date

      t.timestamps
    end
  end
end
