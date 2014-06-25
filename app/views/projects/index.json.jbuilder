json.array!(@projects) do |project|
  json.extract! project, :id, :name, :description, :event_id, :person_id, :organization_id
  json.url project_url(project, format: :json)
end
