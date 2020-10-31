FactoryBot.define do
  factory :user do
    user_name           { Faker::Name.name }
    email               { Faker::Internet.free_email }
    phone_number        { Faker::Number.number(10) }
    date_of_birth       { Faker::Date.between(from: '1998-01-01', to: '2009-01-01') }
    gender              "F"
    password            "123456"
     
  end
end