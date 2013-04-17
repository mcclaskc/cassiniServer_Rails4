class ApiController < ApplicationController
	def uvis
		prepare_response
		respond
	end

	def ephem
		prepare_response
		if @response[:status] == 200
			begin
				@response[:content] = Ephem.where(timestamp: @datetime)
			rescue => e
				@response[:status] = 500
				@response[:details] = e.message
			end
		end
		respond
	end

	def events
		prepare_response
		respond
	end

	private

	#datetime and end_datetime need to look like "2009-06-22 12:00:00"

	def prepare_response
		@response = {status: 200, details: "OK", content: {}}
		if @datetime = params['datetime']
			@end_datetime = params['end_datetime']
			begin 
				@datetime = Time.zone.parse(@datetime)
				@end_datetime = Time.zone.parse(@end_datetime) if @end_datetime
			rescue => e
				@response[:status] = 402
				@response[:details] = "Invalid datetime"
			end
		else
			@response[:status] = 401
			@response[:details] = "Please Include a datetime"
		end
	end

	def respond
		render :json => @response.to_json
	end
end
