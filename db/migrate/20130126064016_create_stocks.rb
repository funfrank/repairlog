class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :device
      t.references :area
      t.integer :rest
      t.integer :warning

      t.timestamps
    end
  end
end
