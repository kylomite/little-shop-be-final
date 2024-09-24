class Api::V1::CouponsController < ApplicationController
    def index
        coupons = Coupon.all

        render json: CouponSerializer.new(coupons).serializable_hash.to_json, status: :ok
    end

    def show
      coupon = Coupon.find(params[:id])
      render json: CouponSerializer.new(coupon).serializable_hash.to_json, status: :ok
    end

    def create
        new_coupon = Coupon.create(coupon_params)
        render json: CouponSerializer.new(new_coupon).serializable_hash.to_json, status: 201
    end

    def update
        updatable_coupon = Coupon.find(params[:id])
        updatable_coupon.update(coupon_params)
        render json: CouponSerializer.new(updatable_coupon)

    end

    private

        def coupon_params
            params.require(:coupon).permit(:name, :code, :value_off, :percent_off, :active, :merchant_id)
        end
end