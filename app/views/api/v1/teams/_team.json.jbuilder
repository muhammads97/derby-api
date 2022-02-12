json.id team.id
json.name team.name
json.size team.players.count
json.captain do
  json.partial! "api/v1/users/minimal", user: team.captain
end
json.players do
  json.array! team.players, partial: "api/v1/users/minimal", as: :user
end
json.created_at team.created_at
json.updated_at team.updated_at