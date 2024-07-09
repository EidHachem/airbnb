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
end
