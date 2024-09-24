class Api::V1::CouponsController < ApplicationController
    def index
        coupons = Coupon.all

        render json: CouponSerializer.new(coupons).serializable_hash.to_json, status: :ok
    end
end