FactoryBot.define do
    factory :coupon do
      name { Faker::Name.first_name }
      code { Faker::Name.last_name }
      value_off { Faker::Number.number(digits:2)}
      percent_off { Faker::Boolean.boolean}
      active { Faker::Boolean.boolean}
      merchant_id { Faker::Number.number(digits:3)}
    end
  end