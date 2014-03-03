class Device < ActiveRecord::Base
  scope :avalible_stocks_area_devices, lambda {|category_id, area_id| joins(:stocks).where("stocks.area_id = ? and stocks.rest > 0 and category_id = ? and enable = 1", area_id, category_id)}
  scope :unavalible_stocks_area_devices, lambda {|category_id, area_id| joins(:stocks).where("stocks.area_id = ? and stocks.rest = 0 and category_id = ? and enable = 1", area_id, category_id)}
  scope :warning_stocks_area_devices, lambda {|category_id, area_id| joins(:stocks).where("stocks.area_id = ? and stocks.rest <= stocks.warning and stocks.rest > 0 and category_id = ? and enable = 1", area_id, category_id)}

  belongs_to :category
  has_many :stocks, :dependent => :destroy
  accepts_nested_attributes_for :stocks, :reject_if => :all_blank
  has_many :stock_logs, :order => "created_at desc", :limit => 20, :dependent => :destroy
  has_many :unavalible_stocks, :class_name => "Stock", :conditions => "rest = 0" 
  has_many :warning_stocks, :class_name => "Stock", :conditions => "rest <= warning and rest > 0"

  has_many :new_stock_logs, :class_name => "StockLog", :conditions => "1 = 0"
  accepts_nested_attributes_for :new_stock_logs

  validates_presence_of :name, :category
  validates_uniqueness_of :name, :scope => :category_id
  validates_numericality_of :price
  validate :stock_in, :on => :update

  def self.unavalible_stocks_area_devices_short(categoryid, areaid)
    text = ''
    Device.unavalible_stocks_area_devices(categoryid, areaid).each do |d|
      text << '[' + d.name + ']' 
    end
    text
  end

  def self.unavalible_stocks_devices_short(categoryid)
    text = ''
    Device.where(:enable => 1, :category_id => categoryid).each do |d|
      if d.unavalible_stocks.length > 0
        text << '<a href="/devices/'+d.id.to_s+'/stock">' + d.name + '</a>:'
        d.unavalible_stocks.each do |ds| 
          text << ds.area.name + '[' + ds.rest.to_s + ']' + '|'
        end
      end
    end
    text
  end

  def self.warning_stocks_area_devices_short(categoryid, areaid)
    text = ''
    Device.warning_stocks_area_devices(categoryid, areaid).each do |d|
      text << '[' + d.name + ']' 
    end
    text
  end

  def self.warning_stocks_devices_short(categoryid)
    text = ''
    Device.where(:enable => 1, :category_id => categoryid).each do |d|
      if d.warning_stocks.length  > 0
        text << '<a href="/devices/'+d.id.to_s+'/stock">' + d.name + '</a>:'
        d.warning_stocks.each do |ds| 
          text << ds.area.name + '[' + ds.rest.to_s + ']' + '|'
        end
      end
    end
    text
  end

  def new_stocks
    Area.where(:category_id => self.category_id).each do |area|
      self.stocks << Stock.new(:area => area, :rest => 0)
    end
  end

  def area_stock(area_id)
    self.stocks.where(:area_id => area_id).first
  end

  def up_stock(area_id, amount=1)
    stock = area_stock(area_id)
    stock.up(amount) 
  end

  def down_stock(area_id, amount=1)
    stock = area_stock(area_id)
    stock.down(amount)
  end
  
  def stock_in
    self.new_stock_logs.each do |log|
      if log.save  
        begin
          down_stock(log.out_area_id, log.amount) if log.out_area_id
          up_stock(log.in_area_id, log.amount)
        rescue => err
          self.errors.add(:stocks, err.to_s)
          false
        end    
      end
    end
  end

  def stocking
    self.new_stock_logs << StockLog.new
    self.new_stock_logs[0].errors.clear
  end

end
