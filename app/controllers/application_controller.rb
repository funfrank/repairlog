class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_filter

  def init_filter
  	if not /user\/register|user\/login|user\/logout/.match(request.env["HTTP_REFERER"])
      session[:referer] = request.env["HTTP_REFERER"]
    else 
      session[:referer] = nil
    end
    
    check_login
  end

  def redirect_back(default)
    redirect_to(session[:referer] || default)
    session[:referer] = nil
  end

  def require_login
    if not @current_user
      redirect_to login_url
      return false
    end
    return true
  end

  def require_admin
    if not @is_admin
      redirect_to login_url
      return false
    end
    return true
  end

  def save_login(user)
    session[:user_id] = user.id
    @current_user = User.find_by_id(session[:user_id])
  end

  def clear_login
    @current_user = nil
    session[:user_id] = nil
    @is_admin = nil
  end

  def check_login
    return nil unless session[:user_id]
    @current_user = User.find_by_id(session[:user_id])
    if @current_user
      if @current_user.is_admin?
        @is_admin = true
      end
    end
  end


  def result_notice_for(key)
    MyI18n.localize(key, :notice) %{ :model => MyI18n.localize_record(params[:controller]) }
  end

  def header_for(word)
    MyI18n.localize(word, :header)
  end  

end
