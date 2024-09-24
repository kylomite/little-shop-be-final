require "rails_helper"

RSpec.describe Coupon do
    it { should belong_to :merchant }

    describe "Instance methods" do
        describe "#toggle_active" do
            it "can toggle a specified coupon/'s active attribute" do
                
                merchant = Merchant.create(name: "test merchant")

                active_coupon = Coupon.create(
                    ({
                        name: "Summer Sale",
                        code: "Bingo",
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

    end
end