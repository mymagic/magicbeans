json.array!(@logs) do |log|
  json.extract! log, :id, :title, :log_type, :type_id, :created_at
  json.url log_url(log, format: :json)
end