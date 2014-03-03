class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.integer :next_id
      t.integer :control
      t.integer :view
      t.integer :category_id
    end
  end
end
