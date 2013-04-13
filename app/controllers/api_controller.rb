class ApiController < ApplicationController
	def uvis
		if params[:date]
			@response = "[success!] TODO return json"		
		else
			uvis = DataFile.first
			@response = {:uvis => {:path => uvis.path, :date => uvis.file_date}}
		end

		respond
	end

	private

	def respond
		render :json => @response.to_json
	end
end
