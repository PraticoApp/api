FactoryGirl.define do
  factory :skill do
    name { Faker::Job.title }
  end
end
