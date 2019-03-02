# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'faker'

Merm.__elasticsearch__.create_index!(force: true)

10.times do |idx|
  name = Faker::Name.first_name

  input = {
      first_name: name,
      last_name: Faker::Name.first_name,
      email: Faker::Internet.email(name),
      password: "password"
  }

  User.create!(input)
end

User.all.each do |user|
  20.times do |idx|
    Merm.create!(
        captured_text: Faker::Lorem.paragraph(2),
        description: Faker::Lorem.paragraph(2),
        last_accessed: 2.days.ago,
        name: Faker::Company.name,
        resource_name: Faker::Company.name,
        resource_url: Faker::Internet.url,
        source: ["Chrome Extension", "merm.io", "Slackbot"].sample,
        owner_id: user.id
    )
  end
end

Merm.all.each do |merm|
  3.times do |idx|
    Tag.create!(
        name: Faker::Company.buzzword,
        merm_id: merm.id
    )
  end
end

Merm.all.each do |merm|
  3.times do |idx|
    Comment.create!(
       content: Faker::Hipster.paragraph(3),
       merm_id: merm.id,
       author_id: User.all.pluck(:id).sample
    )
  end
end