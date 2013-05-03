require 'csv'

class Event < ActiveRecord::Base
	
	# Parses a csv file and creates an Event for each row.
	# I just made sure I was able to input the txt file 
	# we recieved.  It is easily alterable though.
	def self.parse_and_create(csv_file)
		csv = CSV.parse(csv_file.read)
    csv.each do |r|
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
      #TODO add error handling for possible record saving issues
      event.save!  
    end
	end
end
