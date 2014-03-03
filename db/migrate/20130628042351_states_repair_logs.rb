class StatesRepairLogs < ActiveRecord::Migration
  def up
    create_table 'states_repair_logs', :force => true do |t|
      t.column :state_id, :integer
      t.column :repair_log_id, :integer
      t.column :user_id, :integer
      t.column :user2_id, :integer
      t.column :date, :datetime
    end
  end

  def down
  end
end
