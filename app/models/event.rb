class Event < ActiveRecord::Base
	
	def self.parse_and_create(file)
		csv = CSV.parse(file.read)
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
      # p request
      # p start_scet
      # p end_scet
      event.save!  
    end
	end
end
