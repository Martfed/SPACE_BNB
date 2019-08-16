require 'json'
require 'faker'

fake_description ='The Akajor-class shuttle, also referred to simply as the Mandalorian shuttle, was a type of shuttle manufactured by MandalMotors during the Clone Wars for the New Mandalorians. The Akajor-class was not equipped with a hyperdrive,measured at a length of 17.97 meters, and could reach speeds of 900 kilometers per hour. Although unarmed, several owners modified their shuttles to carry weapons. The shuttles had two rotating wings, one on each side, that changed position when landing, and acting as part of the landing gear. The wings were also decorated with Mandalorian designs. The front of the shuttle also had a landing gear leg, and a platform with a ramp that lowered from the rear of the ship for entry and exit. The shuttle could accommodate at least four passengers, and was crewed by at least two pilots.'

puts 'Deleting all countries, users, spaceships, bookings and reviews...'

User.destroy_all
Country.destroy_all


puts 'Reading JSON file...'

@json_path = File.join(__dir__, 'countries.json')
serialized_countries = File.read(@json_path)
countries = JSON.parse(serialized_countries)

puts "Collecting all of the world's countries..."
countries.each do |country|
  Country.create(name: country["name"])
end

puts "Creating users..."

user_images = [
  'https://avatars0.githubusercontent.com/u/52085295?v=4',
  'https://avatars0.githubusercontent.com/u/51639218?v=4',
  'https://avatars2.githubusercontent.com/u/51084422?v=4',
  'https://avatars3.githubusercontent.com/u/51128673?v=4',
  'https://avatars1.githubusercontent.com/u/52044985?v=4',
  'https://avatars2.githubusercontent.com/u/51087021?v=4',
  'https://avatars2.githubusercontent.com/u/52207783?v=4',
  'https://avatars0.githubusercontent.com/u/50140032?v=4',
  'https://avatars2.githubusercontent.com/u/43496861?v=4',
  'https://nbocdn.akamaized.net/Assets/Images_Upload/2011/10/06/21-25810-actualite-apple-steve-jobs.jpg'
]

i = 0
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
  user.remote_image_url = user_images[i]
  user.save
  i += 1
end

users = User.all

puts "Creating master user..."

master_user = User.create(
    first_name:             'Federico',
    last_name:              'Von Pooface',
    species:                'Human',
    email:                  'master@user.com',
    payment_info:           Faker::Stripe.valid_card,
    password:               "master",
    password_confirmation:  "master"
    )
master_user.remote_image_url = 'https://avatars2.githubusercontent.com/u/17019908?v=4'
master_user.save

puts "Master user's email: master@user.com"
puts "Master user's password: master"
puts "Inventing spaceships..."

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

names = ['Milennium Falcon', 'Space Shuttle', 'The Mandalorian Arrow', 'Schiaparelli', 'Corvette', 'Enterprise', 'T-wing', 'Federican Pooface', 'Frankurian Rocket', 'Emoji Carriage']
i = 0

addresses = [
  'Kantersteen 12, 1000 Brussel',
  'Tweedekkerstraat 126, 1130 Brussel',
  'Sint-Lambertusstraat 200, 1200 Sint-Lambrechts-Woluwe',
  'Boondaalsesteenweg 418, 1050 Elsene',
  'Rogierlaan 51, 1030 Schaarbeek',
  'Jean Joseph Crocqlaan 15, 1020 Brussel',
  'Rue Edith Cavell &, Rue Marie Depage, 1180 Uccle',
  'Wayezstraat 160-162, 1070 Anderlecht',
  'Ter Platen 12, 9000 Gent',
  'Gebroeders de Smetstraat 6, 9000 Gent'
]

10.times do
  spaceship = Spaceship.create(
    name:          names[i],
    description:   fake_description,
    address:       addresses[i],
    city:          addresses[i].split(' ').last,
    capacity:      rand(1..9999),
    price:         rand(5000..100000)
    )
  spaceship.country = countries.sample
  if i < 7
    spaceship.user = users.sample
  else
    spaceship.user = master_user
  end
  spaceship.remote_image_url = images[i]
  spaceship.save
  i += 1
end

puts "Invoking bookings..."
spaceships = Spaceship.all

30.times do
  date = Faker::Date.between(from: Date.today, to: 1.year.from_now)
  booking = Booking.create(
    start_date:  date,
    end_date:    date + rand(3..10).days,
    confirmation_status: %w(pending accepted rejected active done).sample,
    )
  booking.user = users.sample
  spaceship = spaceships.sample
  spaceship = spaceships.sample until !(booking.user.spaceships.include? spaceship)
  booking.spaceship = spaceship
  booking.save
end

puts "Invoking master user's bookings..."

10.times do
  date = Faker::Date.between(from: Date.today, to: 1.year.from_now)
  booking = Booking.create(
    start_date:  date,
    end_date:    date + rand(3..10).days,
    confirmation_status: %w(pending accepted rejected active done).sample,
    )
  booking.user = master_user
  spaceship = spaceships.sample
  spaceship = spaceships.sample until !(booking.user.spaceships.include? spaceship)
  booking.spaceship = spaceship
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

puts "Pulling master user's reviews out of my buttocks..."

master_user.bookings.each do |booking|
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
