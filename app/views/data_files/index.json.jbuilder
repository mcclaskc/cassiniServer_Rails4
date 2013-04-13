json.array!(@data_files) do |data_file|
  json.extract! data_file, :path, :file_date, :file_type_id
  json.url data_file_url(data_file, format: :json)
end