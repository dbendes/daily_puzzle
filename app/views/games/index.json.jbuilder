json.array!(@games) do |game|
  json.extract! game, :id, :name, :iframe, :description
  json.url game_url(game, format: :json)
end
