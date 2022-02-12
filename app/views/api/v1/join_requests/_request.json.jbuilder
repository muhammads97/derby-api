json.id request.id
json.status request.status
json.message request.message

json.player do
  json.partial! "api/v1/users/user", user: request.player
end

json.team do
  json.partial! "api/v1/teams/team", team: request.team
end

