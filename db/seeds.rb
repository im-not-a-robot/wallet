# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create admin + balance
admin = User.find_by(email: "admin@google.com")

# Admin
unless admin
  admin = User.create!(name: "Admin", email: "admin@google.com", password: "admin", role: "admin")
end

balance = Balance.find_by(user: admin)
  
# Balance
unless balance
  Balance.create!(user: admin, amount: 0)
end

# Create customer + balance
for i in 1..3
  # Customer
  user = User.find_by(email: "customer#{i}@google.com")

  unless user
    user = User.create!(name: "Customer #{i}", email: "customer#{i}@google.com", password: "customer#{i}", role: "customer")
  end

  balance = Balance.find_by(user: user)
  
  # Balance
  unless balance
    Balance.create!(user: user, amount: 0)
  end
end

# Create action
actions = ["deposit", "withdraw", "transfer", "buy"]

actions.each do |action|
  Action.find_or_create_by(name: action)
end