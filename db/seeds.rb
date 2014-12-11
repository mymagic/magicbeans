# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create(name: 'admin')
User.create(name: 'admin', email: 'admin@magicbeans.com', ic: '910203-10-5123', phone: '0145667896', password: 'password', password_confirmation: 'password', confirmed_at: Time.now)
Log.create(title: 'Created a user', log_type: 'users', type_id: 1)
User.find_by_id(1).roles.push(Role.find_by_name('admin'))
Log.create(title: 'Updated a user', log_type: 'users', type_id: 1)
Program.create(name: 'Programmer Finishing School', description: "Are you a final year computer science/engineering student? We'll coach you both on-site and remotely to polish your communication, collaboration and web development skills.

You'll work as part of a team to design, build, test and deploy an MVP application for a startup. And your work counts as your final year project.

Do well, and your startup might just ask you to stick around after graduation. Or gain the upper hand in the competitive job market for highly paid tech jobs.
Apply NOW for the next intake in January 2015. Limited slots available.", speaker: 'Imran Ismail', speakerbio: 'Rails Developer', biourl: 'www.imranismail.me', keytakeways: 'Learn rails', tags: 'web-dev, rails, programming', resources: 'www.imranismail.me, www.rails.com')
Log.create(title: 'Created a program', log_type: 'programs', type_id: 1)
Activity.create(name: 'Magicbeans',date: Time.now,venue: 'SSTwo Mall, Seksyen 17',description: 'Rails Bootcamp',speaker: 'Imran Ismail',speakerbio: 'Rails Developer',biolink: 'www.imranismail.me',keytakeaway: 'Learn rails',prerequisite: 'SPM', maxattendee: 5,tags: 'web-dev, rails, programming',resources: 'www.imranismail.me, www.rails.com',program_id: 1)
Log.create(title: 'Created an activity', log_type: 'activities', type_id: 1)