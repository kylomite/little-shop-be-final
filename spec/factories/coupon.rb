FactoryBot.define do
    factory :customer do
      name { Faker::Name.first_name }
      code { Faker::Name.last_name }
      value_off { Faker::Number.number(digits:2)}
      percent_off { Faker::Boolean.boolean}
      active { Faker::Boolean.boolean}
      merchant_id { Faker::Number.number(digits:4)}
    end
  end