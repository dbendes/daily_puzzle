json.array!(@email_preferences) do |email_preference|
  json.extract! email_preference, :id, :marketing, :daily, :weekly, :user_id
  json.url email_preference_url(email_preference, format: :json)
end
