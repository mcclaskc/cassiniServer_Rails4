json.array!(@ephems) do |ephem|
  json.extract! ephem, :x, :y, :z, :timestamp, :body_id
  json.url ephem_url(ephem, format: :json)
end