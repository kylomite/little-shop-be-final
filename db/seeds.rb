# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d little_shop_development db/data/little_shop_development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)

system("rails db:migrate")

Coupon.create(name: "test", code: "bogo", value_off: 15, percent_off: true, active: true, merchant_id: 1)

t.string :name
t.string :code
t.integer :value_off
t.boolean :percent_off
t.boolean :active
t.belongs_to :merchant, null: false, foreign_key: true