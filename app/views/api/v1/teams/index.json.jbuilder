json.teams do
  json.array! @teams, partial: "minimal", as: :team
end