json.id team.id
json.name team.name
json.size team.players.count
json.captain do
  json.id team.captain_id
  json.name team.captain.name
end
json.created_at team.created_at
json.updated_at team.updated_at