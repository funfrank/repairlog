class State < ActiveRecord::Base
  SHOW = -1
  EDIT = -2
  DESTROY = -3
  START = 1
  FIXED =  100
  SEARCH = 9
  
  scope :search_states, lambda {|category_id| where("view = ? and category_id = ?", SEARCH, category_id)}
  scope :repair_states, lambda {|category_id, state_id| where("id > ? and category_id = ?", state_id, category_id)}
  
  belongs_to :category
  belongs_to :nstate, :class_name => "State", :foreign_key => "next_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :category_id


  def self.end_state_ids(category_id)
    self.end_states(category_id).map(&:id)
  end

  def self.end_states(category_id)   
    where("next_id is null and category_id = ?", category_id)
  end


  def self.fixed_state_ids(category_id)
    self.fixed_states(category_id).map(&:id)
  end

  def self.fixed_states(category_id)
    where("control = ? and category_id = ?", FIXED, category_id)
  end 

  def self.start_state(category_id)
    where("control = ? and category_id = ?", START, category_id).first
  end

  def self.show_state
    where("control = ?", SHOW).first
  end

  def self.edit_state
    where("control = ?", EDIT).first
  end

   def self.destroy_state
    where("control = ?", DESTROY).first
  end 


   def is_edit?
     control == EDIT
   end

end
