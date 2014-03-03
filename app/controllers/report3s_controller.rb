class Report3sController < ApplicationController
  before_filter :require_login

  def index
    @rpts = [] 

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rpts }
    end
  end

  def search 
    @states_repair_log = StatesRepairLog.searcher(params[:searcher])
    @rpts = @states_repair_log.work_count_rpt(@current_user.category.id)


    respond_to do |format|
      format.html {  redirect_to report_path }
      format.js
    end
  end

end
