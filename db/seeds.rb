# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Style.create(
  name: 'Runway',
  slug: 'runway',
  style_id: 1,
  order: 1
)
Style.create(
  name: 'Stark',
  slug: 'stark',
  style_id: 2,
  order: 2
)
Style.create(
  name: 'Neon',
  slug: 'neon',
  style_id: 3,
  order: 3
)
Style.create(
  name: 'Galactic',
  slug: 'galactic',
  style_id: 4,
  order: 4
)
Style.create(
  name: 'Fast Food',
  slug: 'fastfood',
  style_id: 5,
  order: 5
)