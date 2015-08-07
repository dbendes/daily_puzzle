json.array!(@instructions) do |instruction|
  json.extract! instruction, :id, :url, :description, :game
  json.url instruction_url(instruction, format: :json)
end
