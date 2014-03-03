class Login
  attr_accessor :user
  attr_accessor :area_id
  attr_accessor :category_id


  def initialize(attributes=nil)
    if attributes
      attributes.each do |k, v|
        send(k + "=", v)
      end
    end
  end
  
end
