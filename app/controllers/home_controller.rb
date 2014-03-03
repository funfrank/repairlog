class HomeController < ApplicationController
  before_filter :require_login, :except => [:login, :category_areas]

  def index
    redirect_to  repair_logs_path
  end
  
  def login
    @user = User.new

    if params[:user]
      @user = User.new(params[:user])
      begin
        @user = @user.check_login 
        save_login(@user)        
        redirect_to  '/'
        return
      rescue => err
        flash[:notice] = result_notice_for(err.to_s)         
        if err.to_s.eql? 'failure.login_error_pwd'
          @user.password = ''
        end
      end
    end

    render :action => "login"
  end

  def logout
    clear_login
    redirect_to '/'
  end

  def category_areas
    text = ''
    Area.where(:category_id => params[:category_id]).each do |area|
      text << '<option value="%s">%s</option>' % [area.id, area.name]
    end

    render :text => text
  end

end
