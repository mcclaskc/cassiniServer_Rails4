require 'csv'

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
		file = file.read.gsub(/[(),]/, "").gsub(/[\/: ]/, ",")

		csv = CSV.parse(file)
	    csv.each do |r|
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
	      hour += 12 if pm
	      timestamp = DateTime.new(year, month, day, hour, minute, second)

	      Ephem.new(x: x, y: y, z: z, timestamp: timestamp, body_id: body_id)
	    end
	end

end
