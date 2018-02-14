json.extract! route, :id, :mission_id, :timestamp, :lat, :lon, :alt, :created_at, :updated_at
json.url route_url(route, format: :json)
