class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.integer :value_off
      t.boolean :percent_off
      t.boolean :active
      t.integer :use_count, default: 0
      t.belongs_to :merchant, null: false, foreign_key: true

      t.timestamps
    end
    add_index :coupons, :code, unique: true
  end
end
