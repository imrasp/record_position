# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Initial Role
# @admin = Role.create(name: "Admin")
# Role.create(name: "Follower")
#
# # Admin User
# User.create(email: "admin@ait.asia", password: "secret123", password_confirmation: "secret123", role_id: @admin.id)

@aircraft = Aircraft.create(name: 'Valentine', drone_type: 'Quadrotor', image: "https://static.pexels.com/photos/704748/pexels-photo-704748.jpeg")
@mission = Mission.create(name: 'RedSun', aircraft_id: @aircraft.id, starttime: 1518611425000, endtime: 1518618625000)
RouteGp.create(mission_id: @mission.id, time: 1518611485000, lat: 100.6405192, lon: 13.7657121, alt: 17)
