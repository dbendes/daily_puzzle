json.array!(@scores) do |score|
  json.extract! score, :id, :value, :date, :game_id, :user_id
  json.url score_url(score, format: :json)
end
