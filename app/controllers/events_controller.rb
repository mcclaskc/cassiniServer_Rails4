require 'csv'

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def import_csv
    begin
      file = params[:csv]
      unless file  
        raise "File not found. Did you remember to choose a file to upload?"      
      end
      csv = CSV.parse(file.read)
      csv.each do |r|
      #CSV.foreach('../Downloads/S17.tol.csv') do |r|
        column = 0
        looking_for_next = false
        request = ""
        start_scet = ""
        end_scet = ""
        r[0].each_char do |c|
          if c == ' '
            looking_for_next = true
            next
          end
          if looking_for_next
            column += 1
            looking_for_next = false
          end

          case column
          when 0
            request << c
          when 1
            start_scet << c
          when 2
            end_scet << c
          else
            break
          end
        end
        event = Event.new(request: request, start_scet: start_scet, end_scet: end_scet)
        # p request
        # p start_scet
        # p end_scet
        event.save!  
      end
    rescue => e
      raise e
      #flash[:error] = e
    end
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:request, :start_scet, :end_scet)
    end

end
