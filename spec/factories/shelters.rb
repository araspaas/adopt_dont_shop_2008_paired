FactoryBot.define do
  factory :shelter do
    name {"Van's #{Faker::Creature::Animal.name} Shelter"}
    address {"#{Faker::Address.street_address}"}
    city {"#{Faker::Address.city}"}
    state {"#{Faker::Address.state}"}
    zip {"#{Faker::Address.zip}"}
  end
end
