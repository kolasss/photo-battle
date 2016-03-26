json.merge! round.attributes
json.status round.status
json.target round.target

json.photos round.photos do |photo|
  json.partial! '/api/v1/photos/photo', photo: photo
end
