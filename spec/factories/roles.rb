FactoryBot.define do
  factory :role do
    role_name           { Faker::Name.name }
    role_code           { Faker::Number.number(digits: 3) }
  end
end