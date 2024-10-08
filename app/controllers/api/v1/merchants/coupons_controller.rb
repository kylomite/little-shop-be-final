class Api::V1::Merchants::CouponsController < ApplicationController
    def index
        merchant = Merchant.find(params[:merchant_id])
        coupons = merchant.coupons
        if params[:sort]
            coupons = merchant.coupons.sorted_by_active(params[:sort])
        else
            coupons = merchant.coupons
        end
        render json: CouponSerializer.new(coupons).serializable_hash.to_json
    end

    def show
        coupon = Coupon.find(params[:id])
        render json: CouponSerializer.new(coupon).serializable_hash.to_json
    end

    def create
        begin
            new_coupon = Coupon.create!(coupon_params)
            render json: CouponSerializer.new(new_coupon).serializable_hash.to_json, status: 201
        rescue StandardError => exception
            render json: ErrorSerializer.format_errors([exception.message]), status: :bad_request 
        end
    end

    def update
        updatable_coupon = Coupon.find(params[:id])

        if params[:toggle_active] == "true"
            updatable_coupon.toggle_active
            updatable_coupon.save!
        else 
            updatable_coupon.update!(coupon_params)
        end

        render json: CouponSerializer.new(updatable_coupon)
    end

    private

        def coupon_params
            params.require(:coupon).permit(:name, :code, :value_off, :percent_off, :active, :use_count, :merchant_id)
        end
end