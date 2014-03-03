class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :contractor
      t.string :phone
      t.integer :category_id

      t.timestamps
    end
  end
end
