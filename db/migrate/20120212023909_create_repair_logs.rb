class CreateRepairLogs < ActiveRecord::Migration
  def change
    create_table :repair_logs do |t|
      t.string :posid
      t.references :company
      t.datetime :sendDate
      t.references :failure
      t.references :state
      t.text :note, :sendNote
      t.integer :operator_id
      t.datetime :stateDate
      t.references :category
      t.references :area
      t.decimal :cost, :precision => 8, :scale => 2
      t.string :contractor
      t.string :phone

      t.timestamps
    end
  end
end
