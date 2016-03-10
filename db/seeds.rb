# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do
  Post.create name:    Faker::Company.name,
              title:   Faker::Company.bs,        
              content: Faker::Lorem.paragraph
end

["Programming", "Art", "Science", "Cats", "Sports", 
  "Technology", "Gaming", "Photography", "Hiking", "Biking"].each do |cat|
  Category.create(name: cat)
end