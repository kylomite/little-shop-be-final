require "rails_helper"

RSpec.describe Coupon do
    describe "validations" do

    end

    describe "relationships" do

    end
    describe "Instance methods" do
        describe "#toggle_active" do
        it "can toggle a specified coupon/'s active attribute" do
            
            merchant = Merchant.create(name: "test merchant")

            active_coupon = Coupon.create(
                ({
                    name: "Summer Sale",
                    code: "patsqanny",
                    value_off: 15,
                    percent_off: true,
                    active: true,
                    use_count: 0,
                    merchant_id: merchant.id
                })
            )

            active_coupon.toggle_active

            expect(active_coupon.active).to eq(false)

            active_coupon.toggle_active

            expect(active_coupon.active).to eq(true)
        end
    end
    end
    describe "Class methods" do
        describe ".sorted_by_active" do
            it "can sort coupons showing active coupons first" do

                merchant = Merchant.create(name: "test merchant")

                Coupon.create(
                    ({
                        name: "Summer Sale",
                        code: "asdfdsfsdf",
                        value_off: 15,
                        percent_off: true,
                        active: true,
                        use_count: 0,
                        merchant_id: merchant.id
                    })
                )

                Coupon.create(
                    ({
                        name: "Winter Sale",
                        code: "gfddfgfasy",
                        value_off: 15,
                        percent_off: true,
                        active: false,
                        use_count: 0,
                        merchant_id: merchant.id
                    })
                )
                sorted_list = Coupon.sorted_by_active("active")

                expect(sorted_list.first[:active]).to eq (true)
                expect(sorted_list.last[:active]).to eq (false)
            end

            it "can sort coupons showing inactive coupons first" do

                merchant = Merchant.create(name: "test merchant")

                Coupon.create(
                    ({
                        name: "Summer Sale",
                        code: "asdfdsfsdf",
                        value_off: 15,
                        percent_off: true,
                        active: true,
                        use_count: 0,
                        merchant_id: merchant.id
                    })
                )

                Coupon.create(
                    ({
                        name: "Winter Sale",
                        code: "gfddfgfasy",
                        value_off: 15,
                        percent_off: true,
                        active: false,
                        use_count: 0,
                        merchant_id: merchant.id
                    })
                )

                sorted_list = Coupon.sorted_by_active("inactive")
                
                expect(sorted_list.first[:active]).to eq (false)
                expect(sorted_list.last[:active]).to eq (true)
            end
        end
    end
end