class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :code, :name, :password
      t.references :role
      t.references :category
      t.references :area

      t.timestamps
    end
    add_index :users, :role_id
  end
end
