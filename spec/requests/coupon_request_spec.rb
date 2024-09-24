require "rails_helper"

describe "Coupon endpoints", :type => :request do
    before(:each) do
        Merchant.destroy_all
        Coupon.destroy_all
        @merchants_list = create_list(:merchant, 9)

        @coupons_list = build_list(:coupon, 5) do |coupon|
            coupon.merchant_id =  @merchants_list.sample.id
            coupon.save!
        end

        # @coupon1 = Coupon.create(name: "Summer Sale", code: "Bingo", value_off: 15, percent_off: true, active: true, merchant_id: @merchantsList.sample.id)
        # @coupon2 = Coupon.create(name: "Sweepstakes", code: "marple", value_off: 30, percent_off: true, active: false, merchant_id: @merchantsList.sample.id)
        # @coupon3 = Coupon.create(name: "Fall Sale", code: "2407", value_off: 65, percent_off: false, active: true, merchant_id: @merchantsList.sample.id)
        # @coupon4 = Coupon.create(name: "Winter Sale", code: "1738 Hey Whats up", value_off: 25, percent_off: true, active: true, merchant_id: @merchantsList.sample.id)
        # @coupon5 = Coupon.create(name: "Spring Sale", code: "Full coweling", value_off: 15, percent_off: false, active: false, merchant_id: @merchantsList.sample.id)
        # @coupon6 = Coupon.create(name: "Birthday Special", code: "Gear 5", value_off: 50, percent_off: true, active: true, merchant_id: @merchantsList.sample.id)
        # @couponList = [@coupon, @coupon2, @coupon3, @coupon4, @coupon5, @coupon6]
    end
    
    describe "#index" do
        describe "HAPPY path" do
            it "returns a list of all coupons" do
                get "/api/v1/coupons"

                expect(response).to be_successful

                coupons = JSON.parse(response.body, symbolize_names: true)

                coupons[:data].each do |coupon|
                    expect(coupon[:id]).to be_an(String)
                    expect(coupon[:type]).to eq("coupon")
    
                    expect(coupon[:attributes][:name]).to be_a(String)
                    expect(coupon[:attributes][:code]).to be_a(String)
                    expect(coupon[:attributes][:value_off]).to be_a(Integer)
                    expect(coupon[:attributes][:percent_off]).to be_in([true, false])
                    expect(coupon[:attributes][:active]).to be_in([true, false])
                    expect(coupon[:attributes][:use_count]).to be_a(Integer)
                end
            end
        end

        describe "SAD path" do
            
        end
    end
    

    describe "#show" do
        describe "HAPPY path" do
            it "returns a single coupon" do
                get "/api/v1/coupons/#{@coupons_list[0].id}"

                expect(response).to be_successful
                
                coupon1 = JSON.parse(response.body, symbolize_names: true)

                expect(coupon1[:data][:id]).to eq(@coupons_list[0].id.to_s)
                expect(coupon1[:data][:type]).to eq("coupon")

                expect(coupon1[:data][:attributes][:name]).to eq(@coupons_list[0].name)
                expect(coupon1[:data][:attributes][:code]).to eq(@coupons_list[0].code)
                expect(coupon1[:data][:attributes][:value_off]).to eq(@coupons_list[0].value_off)
                expect(coupon1[:data][:attributes][:percent_off]).to eq(@coupons_list[0].percent_off)
                expect(coupon1[:data][:attributes][:active]).to eq(@coupons_list[0].active)
                expect(coupon1[:data][:attributes][:use_count]).to be_a(Integer)

                get "/api/v1/coupons/#{@coupons_list[1].id}"

                expect(response).to be_successful
                
                coupon2 = JSON.parse(response.body, symbolize_names: true)
                    
                expect(coupon2[:data][:id]).to eq(@coupons_list[1].id.to_s)
                expect(coupon2[:data][:type]).to eq("coupon")

                expect(coupon2[:data][:attributes][:name]).to eq(@coupons_list[1].name)
                expect(coupon2[:data][:attributes][:code]).to eq(@coupons_list[1].code)
                expect(coupon2[:data][:attributes][:value_off]).to eq(@coupons_list[1].value_off)
                expect(coupon2[:data][:attributes][:percent_off]).to eq(@coupons_list[1].percent_off)
                expect(coupon2[:data][:attributes][:active]).to eq(@coupons_list[1].active)
                expect(coupon2[:data][:attributes][:use_count]).to be_a(Integer)
            end
        end

        describe "SAD path" do
            
        end
    end

    describe "#create" do
        describe "HAPPY path" do
            it "creates a new instance of a coupon" do
                coupon_params = {
                    name: "test name",
                    code: "unique code",
                    value_off: 15,
                    percent_off: false,
                    active: true,
                    merchant_id: @merchants_list[0].id,
                    use_count: 4
                }

                headers = { "CONTENT_TYPE" => "application/json" }

                post "/api/v1/coupons", headers: headers, params: JSON.generate(coupon: coupon_params)

                testCoupon = Coupon.last

                expect(response).to be_successful

                expect(testCoupon.name).to eq("test name")
                expect(testCoupon.code).to eq("unique code")
                expect(testCoupon.value_off).to eq(15)
                expect(testCoupon.percent_off).to eq(false)
                expect(testCoupon.active).to eq(true)
                expect(testCoupon.merchant_id).to eq(@merchants_list[0].id)
                expect(testCoupon.use_count).to eq(4)

                expect {
                    post "/api/v1/coupons", headers: headers, params: JSON.generate(coupon: coupon_params)
                }.to change { Coupon.count }.by(1)
            end
        end

        describe "SAD path" do
            
        end
    end

    describe "#update" do
        describe "HAPPY path" do
            it "updates a coupon" do
                old_coupon = @coupons_list[0]
                updated_coupon_params = {name: "New Coupon" }
                headers = { "CONTENT_TYPE" => "application/json"}

                patch "/api/v1/coupons/#{@coupons_list[0].id}", headers: headers, params: JSON.generate(coupon: updated_coupon_params)
                
                expect(response).to be_successful

                new_coupon = JSON.parse(response.body, symbolize_names: true)

                expect(new_coupon[:data][:type]).to eq ("coupon")
                expect(new_coupon[:data][:attributes][:name]). to eq("New Coupon")

                updated_coupon = Coupon.find_by(id: old_coupon.id)
                expect(updated_coupon.name).to_not eq(old_coupon.name)
                expect(updated_coupon.name).to eq("New Coupon")
            end

            it "activates a coupon when specified" do
                
            end
            
            it "deactivates a coupon when specified" do

            end
        end
        describe "SAD path" do
            
        end
    end
end