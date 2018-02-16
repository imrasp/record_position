json.extract! aircraft, :id, :name, :drone_type, :image, :created_at, :updated_at
json.url aircraft_url(aircraft, format: :json)
