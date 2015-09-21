json.array!(@wikiraces) do |wikirace|
  json.extract! wikirace, :id, :start, :end, :racedate, :start_description, :end_description
  json.url wikirace_url(wikirace, format: :json)
end
