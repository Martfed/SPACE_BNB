require 'json'
require 'faker'

fake_description ='The Akajor-class shuttle, also referred to simply as the Mandalorian shuttle, was a type of shuttle manufactured by MandalMotors during the Clone Wars for the New Mandalorians. The Akajor-class was not equipped with a hyperdrive,measured at a length of 17.97 meters, and could reach speeds of 900 kilometers per hour. Although unarmed, several owners modified their shuttles to carry weapons. The shuttles had two rotating wings, one on each side, that changed position when landing, and acting as part of the landing gear. The wings were also decorated with Mandalorian designs. The front of the shuttle also had a landing gear leg, and a platform with a ramp that lowered from the rear of the ship for entry and exit. The shuttle could accommodate at least four passengers, and was crewed by at least two pilots.'

puts 'Deleting all countries, users, spaceship, bookings and reviews...'

User.destroy_all
Country.destroy_all


puts 'Reading JSON file...'

@json_path = File.join(__dir__, 'countries.json')
serialized_countries = File.read(@json_path)
countries = JSON.parse(serialized_countries)

puts "Creating countries..."
countries.each do |country|
  Country.create(name: country["name"])
end


puts "Creating users..."

10.times do
  user = User.create(
    first_name:             Faker::Name.first_name,
    last_name:              Faker::Name.last_name,
    species:                %w(Wookie Human Martian Mandalorian Droid Vulcan Borg Jedi Zetan Calaron).sample,
    email:                  Faker::TvShows::SiliconValley.email,
    payment_info:           Faker::Stripe.valid_card,
    password:               "111111",
    password_confirmation:  "111111"
    )
  user.save
end

puts "Creating spaceships..."

users = User.all
countries = Country.all

10.times do
  spaceship = Spaceship.create(
    name:          Faker::TvShows::TheExpanse.ship,
    description:   fake_description,
    address:       Faker::Address.street_address,
    city:          Faker::Address.city,
    capacity:      rand(1..9999),
    price:         rand(5000..100000)
    )
  spaceship.country = countries.sample
  spaceship.user = users.sample
  spaceship.save
end

puts "Pulling bookings out of my ass..."

spaceships = Spaceship.all

30.times do
  date = Faker::Date.between(from: Date.today, to: 1.year.from_now)
  booking = Booking.create(
    start_date:  date,
    end_date:    date + rand(3..10).days,
    )
  booking.spaceship = spaceships.sample
  booking.user = users.sample
  booking.save
end

puts "Pulling reviews out of my buttocks..."

bookings = Booking.all

bookings.each do |booking|
  4.times do
    date = Faker::Date.between(from: Date.today, to: 1.year.from_now)
    review = Review.create(
      content:    Faker::TvShows::RickAndMorty.quote,
      rating:     rand(0..5)
      )
    review.booking = bookings.sample
    review.save
  end
end

puts "Finished"
