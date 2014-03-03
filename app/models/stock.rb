class Stock < ActiveRecord::Base
  belongs_to :area
  belongs_to :device

  validates_presence_of :area
  validates_numericality_of :rest, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :warning, :only_integer => true, :greater_than => 0
  
  def down(amount=1)
    raise MyI18n.localize('stock_error_zero', 'notice.failure') %{ :area => self.area.name, :device => self.device.name } if self.rest < amount
    self.rest = self.rest - amount  
    save
  end

  def up(amount=1)
    self.rest = self.rest + amount
    save
  end
end

