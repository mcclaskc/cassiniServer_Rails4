class ApiController < ApplicationController
	def uvis
		if params[:date]
			@response = "[success!] TODO return json"		
		else
			@response = "Received No Date Param"
		end

		respond
	end

	private

	def respond
		render :json => @response.to_json
	end
end
