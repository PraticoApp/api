FactoryGirl.define do
  factory :address do
    primary_address { Faker::Address.street_address }
    secondary_address { Faker::Address.secondary_address }
    number { Faker::Address.building_number }
    zip_code { Faker::Address.zip_code }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    user
  end
end
