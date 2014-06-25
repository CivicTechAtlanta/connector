json.array!(@people) do |person|
  json.extract! person, :id, :first_name, :last_name, :project_id, :organization_id, :event_id
  json.url person_url(person, format: :json)
end
