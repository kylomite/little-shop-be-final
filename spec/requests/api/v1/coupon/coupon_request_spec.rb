require "rails_helper"

describe "Coupon endpoints", :type => :request do
    before(:each) do
        Merchant.destroy_all
        Coupon.destroy_all
        @merchantsList = create_list(:merchant, 9)
        #binding.pry
        @couponsList = build_list(:coupon, 5) do |coupon|
            coupon.merchant_id = @merchantsList.sample.id
            coupon.save!
        end    
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
                    expect(coupon[:attributes][:percent_off]).to be_a(Boolean)
                    expect(coupon[:attributes][:active]).to be_a(Boolean)
                end
            end
        end

        describe "SAD path" do
            
        end
    end
    

    describe "#show" do
        describe "HAPPY path" do

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