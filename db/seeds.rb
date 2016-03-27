# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Target.create(
  desc: "Сфотайте зеленое",
  criterion: {
    "color": "green"
  }
)

Target.create(
  desc: "Сфотайте красное",
  criterion: {
    "color": "red"
  }
)

Target.create(
  desc: "Сфотайте синее",
  criterion: {
    "color": "blue"
  }
)


User.create(
  name: 'kolas'
)

User.create(
  name: 'michilly'
)
