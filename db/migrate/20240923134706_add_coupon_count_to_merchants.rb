class AddCouponCountToMerchants < ActiveRecord::Migration[7.1]
  def change
    add_column :merchants, :coupon_count, :integer
  end
end
