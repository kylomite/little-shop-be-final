class Coupon < ApplicationRecord
    belongs_to :merchant
    has_many :invoices

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
end