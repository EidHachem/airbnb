100.times do 
    Property.create!({
    name: Faker::Address.unique.community,
    description: Faker::Lorem.unique.sentence(word_count: 15),
    headline: Faker::Lorem.unique.sentence(word_count: 5),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.secondary_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country
})

end