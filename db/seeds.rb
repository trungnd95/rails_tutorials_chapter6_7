# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Trung Manucian",
             email: "trung@manucian.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: 1,
             activated: true,
             activated_at: Time.zone.now
             )

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now
               )
end

users = User.order(:created_at).take(6)
10.times do
  title = Faker::Lorem.words(1)
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(:title =>  title.to_s, :content => content.to_s) }
end

#Following relationships 
users  = User.all
user = users.first
following = users[2..20]
followers = users[3..10]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}