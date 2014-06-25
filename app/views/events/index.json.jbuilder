json.array!(@events) do |event|
  json.extract! event, :id, :name, :description, :person_id, :project_id, :organization_id
  json.url event_url(event, format: :json)
end
