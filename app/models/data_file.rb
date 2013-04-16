class DataFile < ActiveRecord::Base

	def self.import_and_create(data_file)
		#data_file is expected to be of type ActionDispatch::Http::UploadedFile

		title = data_file.original_filename
		file_type_id = nil
		FileType.pluck(:title, :id).each do |f|
			if title.downcase.include? f[0].downcase
				file_type_id = f[1]
				break
			end
		end
		#uvisFOV_titan_2009-JUN-23.dat
		string_date = ""
		under_count = 0
		title.each_char do |c|
			if under_count == 2
				break if c == '.'
				string_date << c
				next
			elsif c == '_'
				under_count += 1
			end
		end
		
		file_date = Date.parse(string_date)

		path = File.join('public/files/', title)
		File.open(path, "wb") { |f| f.write(data_file.read) }
		
		DataFile.new(path: 'files/'+title, file_date: file_date, file_type_id: file_type_id).save!
	end
end
