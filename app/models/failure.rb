class Failure < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :name, :category
  validates_uniqueness_of :name, :scope => :category_id
end
