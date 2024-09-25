require "rails_helper"

describe "Coupon endpoints", :type => :request do
    before(:each) do
        Merchant.destroy_all
        Coupon.destroy_all

        @merchants_list = create_list(:merchant, 5)

        @coupon1 = Coupon.create(name: "Summer Sale", code: "12345", value_off: 15, percent_off: true, active: true, merchant_id: @merchants_list[0].id)
        @coupon2 = Coupon.create(name: "Sweepstakes", code: "qwerty", value_off: 30, percent_off: true, active: false, merchant_id: @merchants_list[0].id)
        @coupon3 = Coupon.create(name: "Fall Sale", code: "asdfg", value_off: 65, percent_off: false, active: true, merchant_id: @merchants_list[0].id)
        @coupon4 = Coupon.create(name: "Winter Sale", code: "zxcvb", value_off: 25, percent_off: true, active: true, merchant_id: @merchants_list[1].id)
        @coupon5 = Coupon.create(name: "Spring Sale", code: "poiuy", value_off: 15, percent_off: false, active: false, merchant_id: @merchants_list[1].id)
        @coupon6 = Coupon.create(name: "Birthday Special", code: "lkjhg", value_off: 50, percent_off: true, active: true, merchant_id: @merchants_list[2].id)
        @coupon7 = Coupon.create(name: "Summer Sale", code: "mnbvc", value_off: 15, percent_off: true, active: true, merchant_id: @merchants_list[3].id)
        @coupon8 = Coupon.create(name: "Sweepstakes", code: "rfvtgbyhn", value_off: 30, percent_off: true, active: false, merchant_id: @merchants_list[3].id)
        @coupon9 = Coupon.create(name: "Fall Sale", code: "qazwsxedc", value_off: 65, percent_off: false, active: true, merchant_id: @merchants_list[4].id)
        @coupon10 = Coupon.create(name: "Winter Sale", code: "bgtnhymju", value_off: 25, percent_off: true, active: true, merchant_id: @merchants_list[4].id)
        @coupon11 = Coupon.create(name: "Spring Sale", code: "8765ryui", value_off: 15, percent_off: false, active: false, merchant_id: @merchants_list[4].id)
        @coupon12 = Coupon.create(name: "Birthday Special", code: "plkmmklp", value_off: 50, percent_off: true, active: true, merchant_id: @merchants_list[4].id)
        @coupon13 = Coupon.create(name: "Birthday Special", code: "hghgffjjhghg", value_off: 50, percent_off: true, active: true, merchant_id: @merchants_list[4].id)
    end

    describe "#index" do
        describe "HAPPY path" do
            it "returns all coupons for a given merchant " do

                get "/api/v1/merchants/#{@merchants_list[0].id}/coupons"

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

            it "returns all coupons for a given merchant sorted by active or inactive" do
                get "/api/v1/merchants/#{@merchants_list[4].id}/coupons?sort=active"

                expect(response).to be_successful

                coupons = JSON.parse(response.body, symbolize_names: true)

                expect(coupons[:data].first[:attributes][:active]).to eq(true)
                expect(coupons[:data].last[:attributes][:active]).to eq(false)

                get "/api/v1/merchants/#{@merchants_list[4].id}/coupons?sort=inactive"

                expect(response).to be_successful

                coupons = JSON.parse(response.body, symbolize_names: true)
                
                expect(coupons[:data].first[:attributes][:active]).to eq(false)
                expect(coupons[:data].last[:attributes][:active]).to eq(true)
            end
        end

        describe "SAD path" do
            
        end
    end


    describe "#show" do
        describe "HAPPY path" do
            it "returns one coupon for a given merchant based on id" do
                 get "/api/v1/merchants/#{@merchants_list[0].id}/coupons/#{@coupon3.id}"

                expect(response).to be_successful
                coupon = JSON.parse(response.body, symbolize_names: true)

                expect(coupon[:data][:id]).to eq(@coupon3.id.to_s)
                expect(coupon[:data][:type]).to eq("coupon")

                expect(coupon[:data][:attributes][:name]).to be_a(String)
                expect(coupon[:data][:attributes][:code]).to be_a(String)
                expect(coupon[:data][:attributes][:value_off]).to be_a(Integer)
                expect(coupon[:data][:attributes][:percent_off]).to be_in([true, false])
                expect(coupon[:data][:attributes][:active]).to be_in([true, false])
                expect(coupon[:data][:attributes][:use_count]).to be_a(Integer)
            end
        end

        describe "SAD path" do
            
        end
    end

    describe "#create" do
        describe "HAPPY path" do
            it "creates a coupon for a merchant" do

                expect(@merchants_list[0].coupons.count).to eq(3)

                coupon_params = {
                    name: "test name",
                    code: "unique test code",
                    value_off: 15,
                    percent_off: false,
                    active: true,
                    merchant_id: @merchants_list[0].id,
                    use_count: 4
                }
                headers = { "CONTENT_TYPE" => "application/json" }

                post "/api/v1/merchants/#{@merchants_list[0].id}/coupons", headers: headers, params: JSON.generate(coupon: coupon_params)
                
                expect(response).to be_successful

                testCoupon = Coupon.last

                expect(testCoupon.name).to eq("test name")
                expect(testCoupon.code).to eq("unique test code")
                expect(testCoupon.value_off).to eq(15)
                expect(testCoupon.percent_off).to eq(false)
                expect(testCoupon.active).to eq(true)
                expect(testCoupon.merchant_id).to eq(@merchants_list[0].id)
                expect(testCoupon.use_count).to eq(4)

                expect(@merchants_list[0].coupons.count).to eq(4)
            end
        end

        describe "SAD path" do
            it 'returns rescue response when creating a coupon for a merchant with 5 active coupons' do
                
                coupon5_params = {
                    name: "test name",
                    code: "unique test code",
                    value_off: 15,
                    percent_off: false,
                    active: true,
                    merchant_id: @merchants_list[4].id,
                    use_count: 4
                }

                coupon6_params = {
                    name: "test name",
                    code: "bebop maroo",
                    value_off: 15,
                    percent_off: false,
                    active: true,
                    merchant_id: @merchants_list[4].id,
                    use_count: 4
                }

                headers = { "CONTENT_TYPE" => "application/json" }

                post "/api/v1/merchants/#{@merchants_list[4].id}/coupons", headers: headers, params: { coupon: coupon5_params }.to_json

                expect(response.status).to eq(201)

                post "/api/v1/merchants/#{@merchants_list[4].id}/coupons", headers: headers, params: { coupon: coupon6_params }.to_json
        
                expect(response.status).to eq(400)

                error_message = JSON.parse(response.body, symbolize_names: true)

                expect(error_message[:message]).to eq("Your query could not be completed")
                expect(error_message[:errors]).to eq(["Validation failed: Merchant can have a maximum of 5 active coupons."])
            end
        end
    end

    describe "#update" do
        describe "HAPPY path" do
            it "can update a coupon for a merchant" do
                old_coupon = @coupon1
                updated_coupon_params = {name: "New Coupon" }
                headers = { "CONTENT_TYPE" => "application/json"}

                patch "/api/v1/merchants/#{@merchants_list[0].id}/coupons/#{@coupon1.id}", headers: headers, params: JSON.generate(coupon: updated_coupon_params)
                
                expect(response).to be_successful

                new_coupon = JSON.parse(response.body, symbolize_names: true)

                expect(new_coupon[:data][:type]).to eq ("coupon")
                expect(new_coupon[:data][:attributes][:name]). to eq("New Coupon")

                updated_coupon = Coupon.find_by(id: @coupon1.id)
                expect(updated_coupon.name).to_not eq(old_coupon.name)
                expect(updated_coupon.name).to eq("New Coupon")
            end

            it "toggles a coupons active state" do

                headers = { "CONTENT_TYPE" => "application/json"}

                patch "/api/v1/merchants/#{@merchants_list[1].id}/coupons/#{@coupon5.id}?toggle_active=true", headers: headers

                expect(response).to be_successful

                activated_coupon = JSON.parse(response.body, symbolize_names: true)

                expect(activated_coupon[:data][:type]).to eq ("coupon")
                expect(activated_coupon[:data][:attributes][:active]). to eq(true)

                @coupon5.reload

                expect(@coupon5.active).to eq(true)

                patch "/api/v1/merchants/#{@merchants_list[1].id}/coupons/#{@coupon5.id}?toggle_active=true", headers: headers

                expect(response).to be_successful

                activated_coupon = JSON.parse(response.body, symbolize_names: true)

                expect(activated_coupon[:data][:type]).to eq ("coupon")
                expect(activated_coupon[:data][:attributes][:active]). to eq(false)

                @coupon5.reload

                expect(@coupon5.active).to eq(false)
            end
        end

        describe "SAD path" do
            
        end
    end
end
