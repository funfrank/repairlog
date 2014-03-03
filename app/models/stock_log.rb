class StockLog < ActiveRecord::Base
  belongs_to :in_area, :class_name => "Area", :foreign_key => "in_area_id"
  belongs_to :out_area, :class_name => "Area", :foreign_key => "out_area_id"
  
  validates_presence_of :in_area_id
  validates_numericality_of :amount, :only_integer => true, :greater_than_or_equal_to => 1  
  validate :in_area_id do |s|
    if !s.in_area_id.blank? && (s.in_area_id.eql? s.out_area_id)
      s.errors.add(:in_area_id, :in_area_equals_out_area) 
    end
  end
end
