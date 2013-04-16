json.array!(@bodies) do |body|
  json.extract! body, :name
  json.url body_url(body, format: :json)
end