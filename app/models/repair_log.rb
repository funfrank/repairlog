class RepairLog < ActiveRecord::Base
  include MySearch
  attr_accessor  :user2_id

  scope :last_repair_logs, lambda {|id, posid| where("id != ? and posid = ?", id, posid).order('sendDate desc').limit(10)}
  belongs_to :company
  belongs_to :failure
  belongs_to :operator, :class_name => "User", :foreign_key => "operator_id"
  belongs_to :state
  belongs_to :category
  belongs_to :area
  has_many :devices_repair_logs, :dependent => :destroy
  accepts_nested_attributes_for :devices_repair_logs, :reject_if => :all_blank
  has_many :states_repair_logs, :dependent => :destroy
  has_one :new_states_repair_log, :class_name => "StatesRepairLog", :conditions => "1 = 0"
  has_one :fixed_states_repair_log, :class_name => "StatesRepairLog", :include => :state, :conditions => "states.control = 100"

  validates_presence_of :posid, :company, :failure, :state, :sendDate, :area, :category 
  validates_numericality_of :cost

  validate :down_stocks
  validate :posid, :on => :create do |r| 
    r.posid = r.posid.upcase
    unless RepairLog.where("state_id not in (?) and posid = ? and category_id = ?", State.end_state_ids(r.category_id), r.posid, r.category_id).blank?
      r.errors.add(:posid, :posid_no_taked) 
    end
  end  

  def fixed_users
    log = self.fixed_states_repair_log
    names = log.user.name
    names << '&&' + log.user2.name  if log.user2
    names
  end

  def op_links(user) 
    links = []

    links << State.show_state
    if user.area.eql?(self.area) && user.category.eql?(self.category) #&& !user.is_inputer?
      if self.state.nstate 
        links << self.state.nstate
        links << State.edit_state if !self.state.nstate.is_edit? 
      end
    end

    links << State.destroy_state if user.is_admin? 

    links
  end

  def devices_repair_logs_short
    text = ''
    for dr in self.devices_repair_logs do 
        text = text + dr.device.name + '[' + dr.device.price.to_s+ ']' + '|' 
    end 

    text
  end
  
  def devices_repair_logs_sum
    sum = 0
    for dr in self.devices_repair_logs do 
        sum = sum + dr.device.price 
    end 

    sum
  end

  def up_stocks
    self.devices_repair_logs.each do |dr|
      dr.device.up_stock(self.area.id)
    end
  end

  def down_stocks
    begin
      self.devices_repair_logs.each do |dr|
        if dr.new_record?
          dr.price = dr.device.price
          dr.device.down_stock(self.area.id)
        end
      end
    rescue => err
      self.errors.add(:devices, err.to_s)
      false
    end
  end

  def next_do(user)
    self.state = self.state.nstate
    write_state_log(user)

    save
  end

  def write_state_log(user)
    self.stateDate = Time.now    
    self.new_states_repair_log = StatesRepairLog.new(:user => user, :state => self.state, :date => self.stateDate, :user2_id => self.user2_id)      
  end

end
