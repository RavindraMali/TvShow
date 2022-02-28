# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

 channel1 = Channel.create(name: "Discovery")
 channel2 = Channel.create(name: "Ten Sports")
 channel3 = Channel.create(name: "colour")
 channel4 = Channel.create(name: "Jio cinema")

channel1.shows.create(name: 'animal world', start_time: '12:00', end_time: '13:00')
channel1.shows.create(name: 'wild life', start_time: '13:00', end_time: '14:00')
channel1.shows.create(name: 'Talk Show', start_time: '14:00', end_time: '15:00')
channel2.shows.create(name: 'Strategy', start_time: '15:00', end_time: '16:00')
channel2.shows.create(name: 'IPL Highlights', start_time: '16:00', end_time: '17:00')
channel2.shows.create(name: 'Talk Show', start_time: '17:00', end_time: '18:00')
channel3.shows.create(name: 'IPL Showdown', start_time: '12:00', end_time: '13:00')
channel3.shows.create(name: 'Talk with Kohli', start_time: '13:00', end_time: '14:00')
channel3.shows.create(name: 'IPL 2019 Final Highlights', start_time: '14:00', end_time: '15:00')
channel4.shows.create(name: 'MS Dhoni', start_time: '15:00', end_time: '16:00')
channel4.shows.create(name: 'spiderman', start_time: '16:00', end_time: '17:00')
channel4.shows.create(name: 'KGF', start_time: '17:00', end_time: '18:00')