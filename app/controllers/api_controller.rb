##
# Controls the Web API directory 
# For documentation on how to use the API from the client, go here: TODO LINK
class ApiController < ApplicationController

	##
	# Handles requests for files.  
	# Requires params['date'], params['file_type'] 
	# Optional params['end_date']
	def files
		prepare_response
		check_file_type
		check_date
			if @response[:status] == 200
				@response[:content] = DataFile.where(file_date: @date, file_type_id: @file_type_id)
			end	
		respond
	end

	##
	# Handles requests for files.  
	# Requires params['date'], params['file_type'] 
	# Optional params['end_date']
	def ephem
		prepare_response
		check_datetime
		if @response[:status] == 200
			begin
				ephems = []
				list = []
				bodies = Hash[Body.pluck("id", "name")]
				if @end_datetime
					ephems = Ephem.where(timestamp: @datetime..@end_datetime).select("body_id, x, y, z,timestamp")
				else
					ephems = Ephem.where(timestamp: @datetime).select("body_id, x, y, z,timestamp")
				end
				ephems.each do |e|
					list << {
								timestamp: e.timestamp, 
								body: bodies[e.body_id],
								x: e.x,
								y: e.y,
								z: e.z
							}
				end
				@response[:content] = {ephems: list}
			rescue => e
				@response[:status] = 500
				@response[:details] = e.message
			end
		end
		respond
	end

	##
	# Handles requests for event data.  
	# *Not Yet Implemented, sets response to 404
	def events
		check_datetime
		prepare_response
		@response[:status] = 404
		@response[:details] = "Invalid Request"
		respond
	end

	private

	## 
	# Initializes instance variable @response (hash).
	# All API methods use this.
	def prepare_response
		@response = {status: 200, details: "OK", content: {}}
	end

	##
	# Ensures the presence and structure of datetime, then sets it to @datetime.
	# Also checks for end_dateime, and sets it to @end_datetime if found.
	# API methods that require datetime parameters should call this.
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

	##
	# Ensures the presence and structure of date, then sets it to @date.
	# Also checks for end_date, and sets it to @end_datet if found.
	# API methods that require date parameters should call this.
	def check_date
		if @date = params['date']
			@end_date = params['end_date']
			begin
			 	@date = Date.parse(@date)
			 	@end_date = Date.parse(@date_time) if @end_date
			rescue => e
			 	@response[:status] = 502
				@response[:details] = "Invalid date"
			end 
		else
			@response[:status] = 501
			@response[:details] = "Please Include a date"
		end
	end

	##
	# Ensures the presence of validity of file_type, then sets it's 
	# corresponding id to @file_type_id
	# This is used by the files method
	def check_file_type
		if file_type = params['file_type']
			FileType.pluck(:id, :title).each do |ft|
				@file_type_id = ft[0] if file_type.downcase.include? ft[1].downcase
			end
			if @file_type_id.nil?
				@response[:status] = 502
				@response[:details] = "Invalid File Type"
			end
		else
			@response[:status] = 501
			@response[:details] = "Please Include a file_type"
		end
	end

	##
	# Renders the @response hash as jsons
	# Should be called at the end of every API method
	def respond
		render :json => @response.to_json
	end
end
