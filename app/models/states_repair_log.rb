class StatesRepairLog < ActiveRecord::Base
  include MySearch
  
  belongs_to :state
  belongs_to :repair_log
  belongs_to :user
  belongs_to :user2, :class_name => "User", :foreign_key => "user2_id"


  def work_count_rpt(category_id)
    Rpt.delete_all
    write_rpts(
            search({:where => 'state_id in (%s) and user2_id is null' % State.where(:category_id => category_id).map(&:id).join(','),
            :group => 'user_id,state_id', :select => 'user_id,state_id,count(*) as times, 0 as is_helper'})
              )

    write_rpts(
            search({:where => 'state_id in (%s) and user2_id is not null' % State.where(:category_id => category_id).map(&:id).join(','),
            :group => 'user_id,state_id', :select => 'user_id,state_id,count(*) as times, 1 as is_helper'})
              )
    write_rpts(
            search({:where => 'state_id in (%s) and user2_id is not null' % State.where(:category_id => category_id).map(&:id).join(','),
            :group => 'user2_id,state_id', :select => 'user2_id as user_id,state_id,count(*) as times, 1 as is_helper'})
              )
    Rpt.find(:all, :order => 'user_id,state_id')
  end


  def write_rpts(states_repair_logs)
    states_repair_logs.each do |s|
      Rpt.new(:user_id => s.user_id, :state_id => s.state_id, :times => s.times, :is_helper => s.is_helper).save
    end
  end
end
