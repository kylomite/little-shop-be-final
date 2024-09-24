require "rails_helper"

describe "Coupon endpoints", :type => :request do
    before(:each) do
        Merchant.destroy_all
        Coupon.destroy_all
        @merchantsList = create_list(:merchant, 9)
        # binding.pry

        @couponsList = build_list(:coupon, 5) do |coupon|
            coupon.merchant_id =  @merchantsList.sample.id
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
                end
            end
        end

        describe "SAD path" do
            
        end
    end
    

    describe "#show" do
        describe "HAPPY path" do
            it "returns a single coupon" do
                get "/api/v1/coupons/#{@couponsList[0].id}"

                expect(response).to be_successful
                
                coupon1 = JSON.parse(response.body, symbolize_names: true)

                expect(coupon1[:data][:id]).to eq(@couponsList[0].id.to_s)
                expect(coupon1[:data][:type]).to eq("coupon")

                expect(coupon1[:data][:attributes][:name]).to eq(@couponsList[0].name)
                expect(coupon1[:data][:attributes][:code]).to eq(@couponsList[0].code)
                expect(coupon1[:data][:attributes][:value_off]).to eq(@couponsList[0].value_off)
                expect(coupon1[:data][:attributes][:percent_off]).to eq(@couponsList[0].percent_off)
                expect(coupon1[:data][:attributes][:active]).to eq(@couponsList[0].active)

                get "/api/v1/coupons/#{@couponsList[1].id}"

                expect(response).to be_successful
                
                coupon2 = JSON.parse(response.body, symbolize_names: true)
                    
                expect(coupon2[:data][:id]).to eq(@couponsList[1].id.to_s)
                expect(coupon2[:data][:type]).to eq("coupon")

                expect(coupon2[:data][:attributes][:name]).to eq(@couponsList[1].name)
                expect(coupon2[:data][:attributes][:code]).to eq(@couponsList[1].code)
                expect(coupon2[:data][:attributes][:value_off]).to eq(@couponsList[1].value_off)
                expect(coupon2[:data][:attributes][:percent_off]).to eq(@couponsList[1].percent_off)
                expect(coupon2[:data][:attributes][:active]).to eq(@couponsList[1].active)
        end
        end

        describe "SAD path" do
            
        end
    end

    describe "#create" do
        describe "HAPPY path" do

        end

        describe "SAD path" do
            
        end
    end

    describe "#update" do
        describe "HAPPY path" do

        end
        describe "SAD path" do
            
        end
    end

    describe "#destroy" do
        describe "HAPPY path" do

        end
        describe "SAD path" do
            
        end
    end
end