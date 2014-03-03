class Rpt < ActiveRecord::Migration
  def up
    create_table :rpts do |t|
      t.integer :user_id
      t.integer :state_id
      t.integer :times
      t.integer :is_helper
    end    
  end

  def down
  end
end
