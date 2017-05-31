FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    cpf { Faker::Number.number(11) }
    phone { Faker::PhoneNumber.cell_phone }
    gender { User.genders.keys.sample }
    birth_date { Faker::Date.birthday(18, 65) }
  end

  factory :invalid_user, parent: :user do
    first_name nil
    email nil
    password nil
    cpf nil
    phone nil
    gender nil
    birth_date nil
  end
end
