json.array!(@events) do |event|
  json.extract! event, :request, :start_scet, :end_scet
  json.url event_url(event, format: :json)
end