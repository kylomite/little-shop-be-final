class AddUseCountToCoupons < ActiveRecord::Migration[7.1]
  def change
    add_column :coupons, :use_count, :integer, default: 0
  end
end
