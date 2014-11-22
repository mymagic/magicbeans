# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create(name: 'Admin')
User.create(name: 'Admin', email: 'admin@magicbeans.com', password: 'password', password_confirmation: 'password', confirmed_at: Time.now)
User.find_by_id(1).roles.push(Role.find_by_name('Admin'))