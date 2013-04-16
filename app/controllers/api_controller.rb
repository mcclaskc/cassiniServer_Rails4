class ApiController < ApplicationController
	def uvis

	end

	def ephem
		begin
			@response[:content] = Ephem.where(time_stamp: @datetime)
		rescue => e
			@response[:status] = 500
			@respinse[:details] = e
		end
	end

	def events

	end

	private

	def prepare_response
		@response = {status: 200, details: "OK", content: {}}
		if @datetime = params[:datetime]
			begin 
				@datetime = DateTime.parse(datetime)
			rescue
				@response[:status] = 402
				@response[:details] = "Invalid datetime"
			end
		else
			@response[:status] = 401
			@response[:details] = "Please Include a datetime or datetime range"
		end
		respond unless @response[:status] == 200
	end

	def respond
		render :json => @response.to_json
	end
end
