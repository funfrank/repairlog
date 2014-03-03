class RepairLogsController < ApplicationController
  before_filter :require_login
  # GET /repair_logs
  # GET /repair_logs.json
  def index
    @repair_logs = RepairLog.searcher({ :state_id => @current_user.search_state_id, :category_id => @current_user.category.id }).search_with_paginate(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repair_logs }
    end
  end

  # GET /repair_logs/1
  # GET /repair_logs/1.json
  def show
    @repair_log = RepairLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repair_log }
    end
  end

  # GET /repair_logs/new
  # GET /repair_logs/new.json
  def new
    @repair_log = RepairLog.new

    @repair_log.area = @current_user.area
    @repair_log.category = @current_user.category
    @repair_log.state_id = State.start_state(@current_user.category.id).id
    @repair_log.cost = 0

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @repair_log }
    end
  end

  # GET /repair_logs/1/edit
  def edit
    @repair_log = RepairLog.find(params[:id])
  end

  # POST /repair_logs
  # POST /repair_logs.json
  def create
    @repair_log = RepairLog.new(params[:repair_log])
    @repair_log.operator = @current_user
    @repair_log.sendDate = Time.now
    @repair_log.write_state_log(@current_user)

    respond_to do |format|
      if @repair_log.save
        format.html { redirect_to repair_logs_path, notice: result_notice_for('success.create') }
        format.json { render json: @repair_log, status: :created, location: @repair_log }
      else
        format.html { render action: "new" }
        format.json { render json: @repair_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /repair_logs/1
  # PUT /repair_logs/1.json
  def update
    @repair_log = RepairLog.find(params[:id])
    @repair_log.attributes = params[:repair_log]  
    @repair_log.write_state_log(@current_user)

    respond_to do |format|
      if @repair_log.save
        format.html { redirect_to repair_logs_path, notice: result_notice_for('success.update') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @repair_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repair_logs/1
  # DELETE /repair_logs/1.json
  def destroy
    @repair_log = RepairLog.find(params[:id])
    @repair_log.up_stocks
    @repair_log.destroy

    respond_to do |format|
      format.html { redirect_to repair_logs_path }
      format.js 
    end
  end
  
  def next_do    
    @repair_log = RepairLog.find(params[:id])

    respond_to do |format|
      @repair_log.next_do(@current_user)
      @repair_log_id = @repair_log.id 
      format.html { redirect_to repair_logs_path }
      format.js
    end
  end

  def search 
    params[:searcher][:category_id] = @current_user.category.id
    @repair_log = RepairLog.searcher(params[:searcher])
    @repair_logs = @repair_log.search_with_paginate(params[:page])
    
    respond_to do |format|
      format.html {  redirect_to repair_logs_path }
      format.js
    end
  end

  def search_link
    @repair_logs = RepairLog.searcher({ params[:s_key] => params[:s_value], :category_id => @current_user.category.id }).search_with_paginate(params[:page])

    respond_to do |format|
      format.html {  redirect_to repair_logs_path }
      format.js
    end
  end

  def last_repair_log
    id = params[:id] || '0'
    posid = params[:posid] || '0'

    @repair_log = RepairLog.last_repair_logs(id, posid)

    if @repair_log.length > 0
      render :partial => 'repair_logs', :object => @repair_log
    else
      render :partial => 'assets/message', :object => header_for('result_not_found') 
    end
  end

  def contractor_phone
    text = ' | '
    id = params[:id] || '0'
    posid = params[:posid] || ' '
    company_id = params[:company_id] || '0'   

    @repair_log = RepairLog.last_repair_logs(id, posid).first
    if @repair_log       
      text = @repair_log.contractor + '|' + @repair_log.phone 
    else
      begin
        cc = Company.find(company_id)
        text = cc.contractor + '|' + cc.phone
      rescue => err
        text = ' | '
      end    
    end
   
    render :text => text  
  end
end
