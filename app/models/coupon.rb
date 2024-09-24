class Coupon < ApplicationRecord
    belongs_to :merchant
    has_many :invoices

    validates :code, presence: true, uniqueness: true

    def self.sorted_by_active(sort_by)
        if sort_by == "active"
            order(active: :desc)
        else
            order(active: :asc)
        end
    end

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