require 'csv'

class Ephem < ActiveRecord::Base

	

	def self.parse_and_create(file)
		# example csv line: (-53.3, 0.0, 63.2) 6/22/2009 12:00:00 AM

		#searches for a body name in the filename (ie TITAN), if it matches one of the known bodies, it remembers the id
		file_name = file.original_filename
		body_id = nil
		Body.pluck(:name, :id).each do |b|
			if file_name.downcase.include? b[0].downcase
				body_id = b[1]
				break
			end
		end

		#some hacky character replacement going on, making it easier to parse manually
		#a row ends up looking like this: 86.6, -9.4, 164.7, 6, 22, 2009, 11, 59, 00, PM
		file = file.read.gsub(/[(),]/, "").gsub(/[\/: ]/, ",")
		
		#parses the file.  each row will be made into a new Ephem record.  If an error occurs during a row parse, the row id 
		# is remembered and reported. 
		csv = CSV.parse(file)
		errors = []
	    csv.each_with_index do |r, i|
    		begin
		    	#["86.6", "-9.4", "164.7", "6", "22", "2009", "11", "59", "00", "PM"]
		    	x = r[0].to_f
		    	y = r[1].to_f
		    	z = r[2].to_f
		    	month = r[3].to_i
		    	day = r[4].to_i
		    	year = r[5].to_i
		    	hour = r[6].to_i
		    	minute = r[7].to_i
		    	second = r[8].to_i
		    	pm = r[9] == "PM"
		    	hour += 12 if pm and hour != 12
		    	timestamp = DateTime.new(year, month, day, hour, minute, second)

		    	Ephem.new(x: x, y: y, z: z, timestamp: timestamp, body_id: body_id).save!
	        rescue => e
		    	errors << {id: i, msg: e.message}
		    end
	    end
	    errors
	end

end
