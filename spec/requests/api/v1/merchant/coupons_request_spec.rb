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
    end

    describe "#index" do
        describe "HAPPY path" do

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
end
