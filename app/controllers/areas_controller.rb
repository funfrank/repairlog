class AreasController < ApplicationController
  before_filter :require_login
  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.where(:category_id => @current_user.category_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @areas }
    end
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    @area = Area.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/new
  # GET /areas/new.json
  def new
    @area = Area.new
    @area.category = @current_user.category 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/1/edit
  def edit
    @area = Area.find(params[:id])
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(params[:area])

    respond_to do |format|
      if @area.save
        format.html { redirect_to areas_url, notice: result_notice_for('success.create') }
        format.json { render json: @area, status: :created, location: @area }
      else
        format.html { render action: "new" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /areas/1
  # PUT /areas/1.json
  def update
    @area = Area.find(params[:id])

    respond_to do |format|
      if @area.update_attributes(params[:area])
        format.html { redirect_to areas_url, notice: result_notice_for('success.update') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area = Area.find(params[:id])
    cur_area = @area.eql?(@current_user.area) 

    respond_to do |format|
      if @area.destroy
        unless cur_area  
          format.html { redirect_to areas_url, notice: result_notice_for('success.delete') }
          format.json { head :no_content }
        else
          redirect_to logout_url          
          return 
        end
      else
        format.html { redirect_to areas_url, notice: @area.errors.full_messages }
        format.json { head :no_content }        
      end
    end
  end
end
