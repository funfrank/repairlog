class Report4sController < ApplicationController  
  before_filter :require_login

  def index
    @repair_logs = [] 

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repair_logs }
    end
  end

  def search 
    params[:repair_log][:category_id]  = @current_user.category.id
    @repair_log = RepairLog.searcher(params[:repair_log])    
    @repair_logs = @repair_log.search({ :where => 'stateDate <= "%s" ' % (Time.now - (60*60*24*params[:days].to_i)) })
  
    respond_to do |format|
      format.html {  redirect_to report_path }
      format.js
    end
  end

end
