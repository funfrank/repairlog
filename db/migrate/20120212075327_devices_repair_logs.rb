class DevicesRepairLogs < ActiveRecord::Migration
  def up
    create_table 'devices_repair_logs', :force => true do |t|
      t.column :device_id, :integer
      t.column :repair_log_id, :integer
      t.decimal :price, :precision => 8, :scale => 2
    end
  end

  def down
  end
end
