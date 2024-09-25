class Coupon < ApplicationRecord
    belongs_to :merchant
    has_many :invoices


    validates :name, :code, :value_off, :use_count, :merchant_id, presence: true
    validates :code, uniqueness: true
    validate :max_active_coupons, if: :active?

    def toggle_active
        if self.active
            self.active = false
            save
        else 
            self.active = true
            save
        end
    end

    def self.sorted_by_active(sort_by)
        if sort_by == "active"
            order(active: :desc)
        else
            order(active: :asc)
        end
    end

    def max_active_coupons
        if merchant.coupons.where(active: true).count >= 5
          errors.add(:base, 'Merchant can have a maximum of 5 active coupons.')
        end
    end

end