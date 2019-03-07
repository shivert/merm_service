# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'faker'

Merm.__elasticsearch__.create_index!(force: true)

## Hard Code User Account
input = [
 {
     first_name: Faker::Name.first_name,
     last_name: Faker::Name.last_name,
     email: "spencer.hivert@gmail.com",
     password: "password"
 },
 {
     first_name: Faker::Name.first_name,
     last_name: Faker::Name.last_name,
     email: "zach.pustowka@gmail.com",
     password: "password"
 },
 {
     first_name: Faker::Name.first_name,
     last_name: Faker::Name.last_name,
     email: "peterzhang7391@gmail.com",
     password: "password"
 }
]

User.create!(input)

## Create 10 Users
4.times do |idx|
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
  fixed_categories = ["Recent", "Favorites", "Unread Resources"]

  3.times do |idx|
    Category.create!(
        owner_id: user.id,
        name: fixed_categories[idx],
        rank: idx,
        custom: false
    )
  end

  2.times do |idx|
    Category.create!(
       owner_id: user.id,
       name: Faker::Space.star,
       rank: idx + 3,
       custom: true
    )
  end

  user.categories.each do |category|
    6.times do |idx|
      Merm.create!(
          captured_text: Faker::Lorem.paragraph(2),
          description: Faker::Lorem.paragraph(2),
          content_type: CONTENT_TYPES.sample,
          last_accessed: Faker::Time.between(6.days.ago, Date.today, :day),
          name: Faker::Company.name,
          resource_name: Faker::Company.name,
          resource_url: Faker::Internet.url,
          source: ["Browser Extension", "merm.io", "Slackbot"].sample,
          owner_id: user.id,
          category_id: category.id
      )
    end
  end
end

Merm.all.each do |merm|
  3.times do |idx|
    Tag.create!(
        name: Faker::Company.buzzword,
        merm_id: merm.id
    )
  end

  3.times do |idx|
    Comment.create!(
        content: Faker::Hipster.paragraph(3),
        merm_id: merm.id,
        author_id: User.all.pluck(:id).sample
    )
  end
end