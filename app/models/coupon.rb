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
end