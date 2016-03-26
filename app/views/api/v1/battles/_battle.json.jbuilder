json.merge! battle.attributes
json.status battle.status

# json.participations battle.participations do |part|
#   json.merge! part.attributes
#   json.user part.user
# end

json.users battle.users do |user|
  json.merge! user.attributes
  json.status battle.participations.where(user_id: user.id).first.status
end

json.rounds battle.rounds do |round|
  json.partial! '/api/v1/rounds/round', round: round
end
