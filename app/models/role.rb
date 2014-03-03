class Role < ActiveRecord::Base
  def self.search_state_id(role_id, category_id)
    RoleState.search_state(role_id, category_id).state_id
  end
end
