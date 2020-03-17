json.extract! event, :id, :name, :event_schedule, :fee, :created_at, :updated_at
json.url event_url(event, format: :json)
