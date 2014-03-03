class User < ActiveRecord::Base
  ADMIN = 1
  MAINTAINER = 2
  INPUTER = 3
  scope :assistants, lambda {|category_id, user_id| where("role_id != ? and category_id = ? and id != ?", ADMIN, category_id, user_id)}

  belongs_to :role
  belongs_to :area
  belongs_to :category 

  validates_presence_of :code, :password, :name, :role
  validates_uniqueness_of :code, :scope => :category_id


  def is_admin?
    role_id == ADMIN
  end

  def is_maintainer?
    role_id == MAINTAINER
  end

  def is_inputer?
    role_id == INPUTER
  end

  def search_state_id
    Role.search_state_id(role_id, category_id)
  end

  def check_login
    user = User.find(:first, :conditions =>["code = ? and category_id =?", self.code, self.category_id])
    if user && user.password == self.password && user.category_id == self.category_id
      if self.area && self.category
        user.area = self.area
        user.category = self.category
        user.save
      else
        raise 'failure.login_error_no_selected'  
      end
      user
    else
      raise 'failure.login_error_pwd'  
      self
    end
  end

end
