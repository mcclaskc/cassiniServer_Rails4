##
# DataFile is a model of any binary files that the client might request.  DataFiles have a date, body, and the download path.
# See schema.rb for more info.
class DataFile < ActiveRecord::Base

	##
	# Process of importing a data file and creating a new DataFile in the database. 
	# Reuired param: data_file - is expected to be of type ActionDispatch::Http::UploadedFile 
	def self.import_and_create(data_file)
		#example filename: uvisFOV_titan_2009-JUN-23.dat

		title = data_file.original_filename
		
		#searches for a filetype name in the filename (ie UVIS), if it matches one of the known filetypes, it remembers the id
		file_type_id = nil
		FileType.pluck(:title, :id).each do |f|
			if title.downcase.include? f[0].downcase
				file_type_id = f[1]
				break
			end
		end

		#same as above, but for the body (ie TITAN)
		body_id = nil
		Body.pluck(:name, :id).each do |b|
			if title.downcase.include? b[0].downcase
				body_id = b[1]
				break
			end
		end
		
		# parsing the name to extract the date.  assumes the format matches the example above
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

		# create the file path - right now its being stored in public/files/ on the server, but 
		# heroku, the cloud hosting service, has issues remember written files like this.  
		# Need to do amazon hosting or something.
		path = File.join('public/files/', title)
		File.open(path, "wb") { |f| f.write(data_file.read) }
		
		#Finally, create the new DataFile record.
		DataFile.new(path: 'files/'+title, file_date: file_date, file_type_id: file_type_id, body_id: body_id).save!
	end
end
