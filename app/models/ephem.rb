class Ephem < ActiveRecord::Base

	# (-53.3, 0.0, 63.2) 6/22/2009 12:00:00 AM

	def self.parse_and_create(file)

		file_name = file.original_filename
		body_id = nil
		Body.pluck(:name, :id).each do |b|
			if file_name.downcase.include? b[0].downcase
				body_id = b[1]
				break
			end
		end

		csv = CSV.parse(file.read)
	    csv.each do |r|
	      p r  
	    end
	end

end
