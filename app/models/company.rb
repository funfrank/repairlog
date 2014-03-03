class Company < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :category_id
  validates_numericality_of :phone
end

