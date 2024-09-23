FactoryBot.define do
    factory :coupon do
      name { Faker::JapaneseMedia::OnePiece.quote }
      code { Faker::JapaneseMedia::OnePiece.island }
      value_off { Faker::Number.number(digits:2)}
      percent_off { Faker::Boolean.boolean}
      active { Faker::Boolean.boolean}
      merchant_id { "" }
    end
  end