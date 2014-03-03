class FailuresController < ApplicationController
  before_filter :require_login
  # GET /failures
  # GET /failures.json
  def index
    @failures = Failure.where(:category_id => @current_user.category.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @failures }
    end
  end

  # GET /failures/1
  # GET /failures/1.json
  def show
    @failure = Failure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @failure }
    end
  end

  # GET /failures/new
  # GET /failures/new.json
  def new
    @failure = Failure.new
    @failure.category = @current_user.category

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @failure }
    end
  end

  # GET /failures/1/edit
  def edit
    @failure = Failure.find(params[:id])
  end

  # POST /failures
  # POST /failures.json
  def create
    @failure = Failure.new(params[:failure])

    respond_to do |format|
      if @failure.save
        format.html { redirect_to failures_path, notice: result_notice_for('success.create') }
        format.json { render json: @failure, status: :created, location: @failure }
      else
        format.html { render action: "new" }
        format.json { render json: @failure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /failures/1
  # PUT /failures/1.json
  def update
    @failure = Failure.find(params[:id])

    respond_to do |format|
      if @failure.update_attributes(params[:failure])
        format.html { redirect_to failures_path, notice: result_notice_for('success.update') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @failure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /failures/1
  # DELETE /failures/1.json
  def destroy
    @failure = Failure.find(params[:id])
    @failure.destroy

    respond_to do |format|
      format.html { redirect_to failures_url }
      format.json { head :no_content }
    end
  end
end
