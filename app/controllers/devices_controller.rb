class DevicesController < ApplicationController
  before_filter :require_login
  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.where(:category_id => @current_user.category.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @devices }
    end
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
    @device = Device.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @device }
    end
  end

  # GET /devices/new
  # GET /devices/new.json
  def new
    @device = Device.new
    @device.category = @current_user.category
    @device.new_stocks

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @device }
    end
  end

  # GET /devices/1/edit
  def edit
    @device = Device.find(params[:id])
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(params[:device])

    respond_to do |format|
      if @device.save
        format.html { redirect_to devices_path, notice: result_notice_for('success.create') }
        format.json { render json: @device, status: :created, location: @device }
      else
        format.html { render action: "new" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /devices/1
  # PUT /devices/1.json
  def update
    if 'stock_in'.eql? params[:button]
      stock_in
      return
    end

    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.update_attributes(params[:device])
        format.html { redirect_to devices_path, notice: result_notice_for('success.update') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device = Device.find(params[:id])
    @device.destroy

    respond_to do |format|
      format.html { redirect_to devices_url }
      format.json { head :no_content }
    end
  end


  def stock
    @device = Device.find(params[:id])
    @device.stocking
  end

  def stock_in
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.update_attributes(params[:device])
        stock
        format.html { render action: "stock", notice: result_notice_for('success.stock_in') }
        format.json { head :no_content }
      else
        format.html { render action: "stock" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
    
  
  end

  
end
