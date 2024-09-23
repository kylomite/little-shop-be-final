FactoryBot.define do
    factory :coupon do
        name { Faker::JapaneseMedia::OnePiece.island }
        code { Faker::JapaneseMedia::OnePiece.quote }
        value_off { Faker::Number.number(digits: 10) }
        percent_off {Faker::Boolean.boolean} 
        active {Faker::Boolean.boolean}
    end
end