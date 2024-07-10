user = User.create!({
  email: 'test@test1.com',
  password: 123456,
})

100.times do |i|
  image_index_1 = (i % 12) + 1
  image_index_2 = ((i + 6) % 12) + 1

  property = Property.create!({
    name: Faker::Address.unique.community,
    description: Faker::Lorem.unique.sentence(word_count: 15),
    headline: Faker::Lorem.unique.sentence(word_count: 5),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.secondary_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    price: Money.new(Faker::Number.between(from: 10, to: 1000) * 100, 'USD')
  })

  property.images.attach(io: File.open("db/images/property_#{image_index_1}.png"), filename: "property_#{image_index_1}.png")
  property.images.attach(io: File.open("db/images/property_#{image_index_2}.png"), filename: "property_#{image_index_2}.png")

  (5..10).to_a.sample.times do |j|
    Review.create!({
      content: Faker::Lorem.paragraph(sentence_count: 5),
      cleanliness_rating: Faker::Number.between(from: 1, to: 5),
      accuracy_rating: Faker::Number.between(from: 1, to: 5),
      checkin_rating: Faker::Number.between(from: 1, to: 5),
      communication_rating: Faker::Number.between(from: 1, to: 5),
      location_rating: Faker::Number.between(from: 1, to: 5),
      value_rating: Faker::Number.between(from: 1, to: 5),
      property: property,
      user: user
    })
  end
end
