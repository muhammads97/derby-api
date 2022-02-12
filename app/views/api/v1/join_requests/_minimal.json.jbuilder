json.id request.id
json.status request.status
json.message request.message
json.player do
  json.id request.player_id
  json.name request.player.name
end

json.team do
  json.id request.team_id
  json.name request.team.name
end

