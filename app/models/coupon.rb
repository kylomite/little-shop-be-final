class Coupon < ApplicationRecord
    belongs_to :merchant

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