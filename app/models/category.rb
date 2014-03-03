class Category < ActiveRecord::Base
  validates_presence_of :name, :posid
  validates_uniqueness_of :name


  def reports
    self.rpts.split(',')
  end
end
