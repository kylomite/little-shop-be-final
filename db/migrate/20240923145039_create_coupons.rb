class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.integer :value_off
      t.boolean :percent_off
      t.boolean :active
      t.belongs_to :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
