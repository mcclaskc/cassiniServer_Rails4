class ApiController < ApplicationController
	def uvis
		prepare_response
		check_file_type
		check_date
			if @response[:status] = 200
				
			end	
		respond
	end

	def ephem
		prepare_response
		check_datetime
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
		check_datetime
		prepare_response
		@response[:status] = 404
		@response[:details] = "Invalid Request"
		respond
	end

	private

	#datetime and end_datetime need to look like "2009-06-22 12:00:00"

	def prepare_response
		@response = {status: 200, details: "OK", content: {}}
	end

	def check_datetime
		if @datetime = params['datetime']
			@end_datetime = params['end_datetime']
			begin 
				@datetime = Time.zone.parse(@datetime)
				@end_datetime = Time.zone.parse(@end_datetime) if @end_datetime
			rescue => e
				@response[:status] = 502
				@response[:details] = "Invalid datetime"
			end
		else
			@response[:status] = 501
			@response[:details] = "Please Include a datetime"
		end
	end

	def check_date
		if @date = params['date']
			@end_date = params['end_date']
			begin
			 	@date = Date.parse(@date)
			 	@end_date = Date.parse(@date_time)
			rescue => e
			 	@response[:status] = 502
				@response[:details] = "Invalid datetime"
			end 
		else
			@response[:status] = 501
			@response[:details] = "Please Include a date"
		end
	end

	def get_file_type_id
		if file_type = params['file_type']
			file_type_id = nil
			FileType.pluck(:id, :title).each do |ft|
				file_type_id = ft[0] if file_type.downcase.include? ft[1].downcase
			end
			if file_type_id.nil?
				@response[:status] = 502
				@response[:details] = "Invalid File Type"
			end
		else
			@response[:status] = 501
			@response[:details] = "Please Include a file_type"
		end
	end

	def respond
		render :json => @response.to_json
	end
end
