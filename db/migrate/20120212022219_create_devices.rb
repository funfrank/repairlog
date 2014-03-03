class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.integer :enable
      t.integer :category_id
      t.decimal :price, :precision => 8, :scale => 2
      t.timestamps
      
    end
  end
end
