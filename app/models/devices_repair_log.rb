class DevicesRepairLog < ActiveRecord::Base
  belongs_to :device
  belongs_to :repair_log
end
