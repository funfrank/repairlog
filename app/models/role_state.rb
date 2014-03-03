class RoleState < ActiveRecord::Base
  def self.search_state(role_id, category_id)
    where("role_id = ? and category_id = ?", role_id, category_id).first
  end
end
