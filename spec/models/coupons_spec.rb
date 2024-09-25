require "rails_helper"

RSpec.describe Coupon do
    describe "validations" do
        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:code) }
        it { should validate_presence_of(:value_off) }
        it { should validate_presence_of(:use_count) }
        it { should validate_presence_of(:merchant_id) }
    end

    describe "relationships" do
        it { should have_many :invoices }
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
        describe "#max_active_coupons" do
            it "does not allow for more than 5 active coupons" do
                merchant = Merchant.create(name: "test merchant")

                coupon1 = Coupon.create(name: "Summer Sale", code: "12345", value_off: 15, percent_off: true, active: true, merchant_id: merchant.id)
                coupon2 = Coupon.create(name: "Sweepstakes", code: "qwerty", value_off: 30, percent_off: true, active: true, merchant_id: merchant.id)
                coupon3 = Coupon.create(name: "Fall Sale", code: "asdfg", value_off: 65, percent_off: false, active: true, merchant_id: merchant.id)
                coupon4 = Coupon.create(name: "Winter Sale", code: "zxcvb", value_off: 25, percent_off: true, active: true, merchant_id: merchant.id)
                coupon5 = Coupon.create(name: "Spring Sale", code: "poiuy", value_off: 15, percent_off: false, active: true, merchant_id: merchant.id)

                coupon6 = Coupon.create(name: "New Coupon", code: "NEW123", value_off: 5, percent_off: false, active: true, merchant_id: merchant.id)

                expect(coupon6.valid?).to be_falsey
                expect(coupon6.errors[:base]).to include('Merchant can have a maximum of 5 active coupons.')
            end


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