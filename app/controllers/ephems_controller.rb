class EphemsController < ApplicationController
  before_action :set_ephem, only: [:show, :edit, :update, :destroy]

  # GET /ephems
  # GET /ephems.json
  def index
    @ephems = Ephem.page(params[:page])
  end

  # GET /ephems/1
  # GET /ephems/1.json
  def show
  end

  # GET /ephems/new
  def new
    @ephem = Ephem.new
  end

  # GET /ephems/1/edit
  def edit
  end

  # POST /ephems
  # POST /ephems.json
  def create
    @ephem = Ephem.new(ephem_params)

    respond_to do |format|
      if @ephem.save
        format.html { redirect_to @ephem, notice: 'Ephem was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ephem }
      else
        format.html { render action: 'new' }
        format.json { render json: @ephem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ephems/1
  # PATCH/PUT /ephems/1.json
  def update
    respond_to do |format|
      if @ephem.update(ephem_params)
        format.html { redirect_to @ephem, notice: 'Ephem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ephem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ephems/1
  # DELETE /ephems/1.json
  def destroy
    @ephem.destroy
    respond_to do |format|
      format.html { redirect_to ephems_url }
      format.json { head :no_content }
    end
  end

    ##
  # Page to which the upload csv form is sent. It checks to see if the file is there, then 
  # calls Event.parse_and_create(file).  Errors are caught and rendered after redirected 
  # back to the ephems index page. 
  def import_csv
    begin
      file = params[:csv]
      raise "File not found. Did you remember to choose a file to upload?" unless file     
      start = Time.now
      errors = Ephem.parse_and_create(file)
      upload_time = Time.now - start
      notice = "Upload Time: #{upload_time}\nFailed Rows: "
      errors.each {|e| notice << "#{e[:id]}, " }
      flash[:notice] = notice
    rescue => e
      flash[:notice] = " * An error occured during import: #{e.inspect}"
    end
    redirect_to :back, :errors => errors, :upload_time => upload_time
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ephem
      @ephem = Ephem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ephem_params
      params.require(:ephem).permit(:x, :y, :z, :timestamp, :body_id)
    end
end
