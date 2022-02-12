json.id user.id
json.name user.name
json.email user.email 
json.phone_number user.phone_number
json.phone_number_verified user.phone_number_verified
json.role user.role
json.status user.status
if user.team
  json.team do
    json.id user.team_id
    json.name user.team.name
  end
else
  json.team nil
end