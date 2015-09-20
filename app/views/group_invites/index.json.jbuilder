json.array!(@group_invites) do |group_invite|
  json.extract! group_invite, :id, :email, :group_id
  json.url group_invite_url(group_invite, format: :json)
end
