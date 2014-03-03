class Area < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :category, :name
  validates_uniqueness_of :name, :scope => :category_id
  before_destroy :check_stocks

  def check_stocks
    begin
      raise MyI18n.localize('stock_exists', 'notice.failure') %{ :area => self.name } if Stock.where(:area_id => self.id).count > 0
    rescue => err
      self.errors.add(:base, err.to_s)
      false
    end
  end
  
end
