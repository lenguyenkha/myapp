User.create!(name: "Le Cao Dat", email: "lecaodat1909@gmail.com",
  password: "123456", password_confirmation: "123456", is_admin: true,
  activated: true, activated_at: Time.zone.now)

9.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@gmail.com"
  password = "password"
  User.create!(name: name, email: email, password: password, password_confirmation: password,
    activated: true, activated_at: Time.zone.now)
end

Category.create!(name: "Foods", parent_id: 0)
Category.create!(name: "Drinks", parent_id: 0)
food = Category.find_by name: "Foods"
drink = Category.find_by name: "Drinks"

3.times do |n|
  name = Faker::Name.name
  parent_id = food.id
  Category.create!(name: name, parent_id: parent_id)
end

3.times do |n|
  name = Faker::Name.name
  parent_id = drink.id
  Category.create!(name: name, parent_id: parent_id)
end

categories = Category.all
10.times do
  price = 10000
  quantity = 100
  categories.each{|category| category.products.create!(name: Faker::Name.name, detail: Faker::Lorem.sentence(20), price: price, quantity: quantity)}
end

users = User.take(5)
3.times do |n|
  users.each do |user|
    order = user.orders.create(total: 0)
    order.created_at = rand(30).days.ago
    order.status = rand(0..1)
    order.save
  end
end

orders = Order.all
products = Product.take(2)
orders.each do |order|
  2.times do |n|
    products.each do |product|
      order_detail = order.order_details.new quantity: rand(1..10)
      product.order_details << order_detail
    end
  end
end

users.each do |user|
  products.each do |product|
    rating = user.ratings.new rate:4
    product.ratings << rating
  end
end

users.each do |user|
  products.each do |product|
    comment = user.comments.new content: Faker::Lorem.sentence(5)
    product.comments << comment
  end
end
