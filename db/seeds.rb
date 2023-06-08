# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create user
user = User.find_by(email: "mail@google.com")

unless user
  User.create!(name: "google", email: "mail@google.com", password: "google")
end

# Create action
actions = ["deposit", "withdraw", "transfer"]

actions.each do |action|
  Action.find_or_create_by(name: action)
end