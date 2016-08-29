# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: "Hoang Mirs",
             email: "hoang@gmail.com",
             chatwork_id: "hoang.mirs",
             password: "123456",
             password_confirmation: "123456",
             role: 1)

User.create!(name: "Test User",
             email: "test@gmail.com",
             chatwork_id: "test.user",
             password: "123456",
             password_confirmation: "123456")
30.times do |n|
  name = "Fake subject name #{n+1}"
  question_number = rand(20..30)
  duration = rand(20..30)
  Subject.create! name: name,
                  question_number: question_number,
                  duration: duration
end
