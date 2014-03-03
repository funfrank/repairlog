class CreateFailures < ActiveRecord::Migration
  def change
    create_table :failures do |t|
      t.string :name
      t.integer :category_id

      t.timestamps
    end
  end
end
