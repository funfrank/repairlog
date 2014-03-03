# encoding: utf-8
class Initialize < ActiveRecord::Migration
  def up
    Role.new(:name => '管理员').save
    Role.new(:name => '维修员').save
    Role.new(:name => '登记员').save

    Category.new(:name => '公交车载机', :posid => '车载机', :rpts => 'report1,report2').save
    Category.new(:name => '出租车GPS', :posid => '车号', :rpts => 'report3,report4').save

    User.new(:code => 'root', :password => 'admin', :name => 'admin', :role_id => 1, :category_id => 1).save
    User.new(:code => 'root', :password => 'admin', :name => 'admin', :role_id => 1, :category_id => 2).save

    Area.new(:name => '城南', :category_id => 1).save
    Area.new(:name => '城南', :category_id => 2).save
    
    State.new(:name => 'show', :control => -1).save
    State.new(:name => 'edit', :control => -2).save
    State.new(:name => 'destroy', :control => -3).save
    
    State.new(:name => '登记', :category_id => 1, :control => 1, :next_id => 2).save
    State.new(:name => '返厂', :category_id => 1, :view => 9, :next_id => 6).save
    State.new(:name => '返厂修复', :category_id => 1, :next_id => 2).save
    State.new(:name => '修复', :category_id => 1, :view => 9, :next_id => 9).save
    State.new(:name => '报废', :category_id => 1).save
    State.new(:name => '领用', :category_id => 1, :control => 100).save

    State.new(:name => '未修理', :category_id => 2, :control => 1, :next_id => 11).save
    State.new(:name => '已电话', :category_id => 2, :next_id => 2, :view => 9).save
    State.new(:name => '已修复', :category_id => 2, :control => 0).save
    State.new(:name => '故障恢复', :category_id => 2).save

    RoleState.new(:role_id => 1, :category_id => 1, :state_id => 4)
    RoleState.new(:role_id => 2, :category_id => 1, :state_id => 4)
    RoleState.new(:role_id => 1, :category_id => 2, :state_id => 11)
    RoleState.new(:role_id => 2, :category_id => 2, :state_id => 11)
    RoleState.new(:role_id => 3, :category_id => 2, :state_id => 10)

  end

  def down
  end
end
