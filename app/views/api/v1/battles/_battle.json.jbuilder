json.merge! battle.attributes
json.status battle.status

# json.participations battle.participations do |part|
#   json.merge! part.attributes
#   json.user part.user
# end

json.users battle.users do |user|
  json.merge! user.attributes
  user_part = battle.participations.where(user_id: user.id).first
  json.status user_part.status
  json.winners_count user_part.winners_count
end

json.rounds battle.rounds do |round|
  json.partial! '/api/v1/rounds/round', round: round
end
