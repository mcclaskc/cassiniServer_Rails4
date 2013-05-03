class DataFilesController < ApplicationController
  before_action :set_data_file, only: [:show, :edit, :update, :destroy]

  # GET /data_files
  # GET /data_files.json
  def index
    @data_files = DataFile.page(params[:page])
  end

  # GET /data_files/1
  # GET /data_files/1.json
  def show
  end

  # GET /data_files/new
  def new
    @data_file = DataFile.new
  end

  # GET /data_files/1/edit
  def edit
  end

  # POST /data_files
  # POST /data_files.json
  def create
    @data_file = DataFile.new(data_file_params)

    respond_to do |format|
      if @data_file.save
        format.html { redirect_to @data_file, notice: 'Data file was successfully created.' }
        format.json { render action: 'show', status: :created, location: @data_file }
      else
        format.html { render action: 'new' }
        format.json { render json: @data_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data_files/1
  # PATCH/PUT /data_files/1.json
  def update
    respond_to do |format|
      if @data_file.update(data_file_params)
        format.html { redirect_to @data_file, notice: 'Data file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @data_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_files/1
  # DELETE /data_files/1.json
  def destroy
    @data_file.destroy
    respond_to do |format|
      format.html { redirect_to data_files_url }
      format.json { head :no_content }
    end
  end

  ##
  # Page to which the upload csv form is sent. It checks to see if the file is there, then 
  # calls Event.parse_and_create(file).  Errors are caught and rendered after redirected 
  # back to the Events index page.   
  def import_file
    begin
      file = params[:file]
      raise "File not found. Did you remember to choose a file to upload?" unless file     
      DataFile.import_and_create(file)
    rescue => e
      flash[:notice] = " * An error occured during import: " + e.message;
    end
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_file
      @data_file = DataFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def data_file_params
      params.require(:data_file).permit(:path, :file_date, :file_type_id)
    end
end
