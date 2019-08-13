require 'json'
# require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Deleting all countries...'
Country.destroy_all

puts 'Reading JSON file...'

countries = File.open('./countries.json', 'r')
country_list = JSON.parse(countries)

puts "Creating countries..."
country_list.each do |country|
  Country.create(name: country.name)
end

puts "Finished"

# spaceship1 = Spaceship.new(name: 'The Mandalorian Arrow', description: "It's a super shiny nice ship yo", address: 'Cantersteen 18', city: "Brussels", country: "Belgium", capacity: 38)
# spaceship1.save
