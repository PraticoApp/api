FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    cpf { Faker::Number.number(11) }
    phone { Faker::PhoneNumber.cell_phone }
    gender { Faker::Number.between(0, 2) }
    birth_date { Faker::Date.birthday(18, 65) }
  end
end
