class EphemsController < ApplicationController
  before_action :set_ephem, only: [:show, :edit, :update, :destroy]

  # GET /ephems
  # GET /ephems.json
  def index
    @ephems = Ephem.all
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
