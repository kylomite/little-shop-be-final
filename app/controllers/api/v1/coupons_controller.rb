class Api::V1::CouponsController < ApplicationController
    def index
        coupons = Coupon.all

        render json: CouponSerializer.new(coupons).serializable_hash.to_json, status: :ok
    end

    def show
      coupon = Coupon.find(params[:id])
      render json: CouponSerializer.new(coupon).serializable_hash.to_json, status: :ok
    end

end