class CreateRoleStates < ActiveRecord::Migration
  def change
    create_table :role_states do |t|
      t.integer  :category_id
      t.integer  :role_id
      t.integer  :state_id
      
    end
  end
end
