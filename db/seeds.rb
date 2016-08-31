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
20.times do |n|
  name = Faker::Name.name
  email = "trainee-#{n+1}@gmail.com"
  password = "123456"
  password_confirmation = "123456"
  chatwork_id = "123456"
  User.create!(name: name, email: email, chatwork_id: chatwork_id, password: password,
               password_confirmation: password, role: 0)
end

20.times do |n|
  content = Faker::Name.name
  answer_type = 1
  status = 1
  subject_id = 1
  user_id = 1
  Question.create!(content: content, answer_type: answer_type,
    status: status, user_id: user_id, subject_id: subject_id)
end

30.times do |n|
  name = "Fake subject name #{n+1}"
  question_number = rand(20..30)
  duration = rand(20..30)
  Subject.create! name: name,
                  question_number: question_number,
                  duration: duration
end
