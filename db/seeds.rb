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

images = [
  'https://res.cloudinary.com/di1eyazrv/image/upload/v1565708314/spaceship08_jdzyvm.jpg',
  'https://res.cloudinary.com/di1eyazrv/image/upload/v1565708313/spaceship07_iaioks.jpg',
  'https://res.cloudinary.com/di1eyazrv/image/upload/v1565708314/spaceship10_hdbqbc.jpg',
  'https://res.cloudinary.com/di1eyazrv/image/upload/v1565708314/spaceship05_ukeiwq.jpg',
  'https://res.cloudinary.com/di1eyazrv/image/upload/v1565708314/spaceship04_vjujko.jpg',
  'https://res.cloudinary.com/di1eyazrv/image/upload/v1565708315/spaceship01_feczey.jpg',
  'https://res.cloudinary.com/di1eyazrv/image/upload/v1565708316/spaceship03_qscjsl.jpg',
  'https://res.cloudinary.com/di1eyazrv/image/upload/v1565708330/spaceship09_d6q3al.jpg',
  'https://res.cloudinary.com/di1eyazrv/image/upload/v1565708332/spaceship02_elh8or.jpg',
  'https://res.cloudinary.com/di1eyazrv/image/upload/v1565708334/spaceship06_dszz5r.jpg'
]
i = 0

10.times do
  i += 1
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
  spaceship.remote_image_url = images[i]
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
