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

Coupon.create(name: "Summer Sale", code: "12345", value_off: 15, percent_off: true, active: true, merchant_id: 1)
Coupon.create(name: "Sweepstakes", code: "qwerty", value_off: 30, percent_off: true, active: false, merchant_id: 1)
Coupon.create(name: "Fall Sale", code: "asdfg", value_off: 65, percent_off: false, active: true, merchant_id: 1)
Coupon.create(name: "Winter Sale", code: "zxcvb", value_off: 25, percent_off: true, active: true, merchant_id: 2)
Coupon.create(name: "Spring Sale", code: "poiuy", value_off: 15, percent_off: false, active: false, merchant_id: 2)
Coupon.create(name: "Birthday Special", code: "lkjhg", value_off: 50, percent_off: true, active: true, merchant_id: 3)
Coupon.create(name: "Summer Sale", code: "mnbvc", value_off: 15, percent_off: true, active: true, merchant_id: 4)
Coupon.create(name: "Sweepstakes", code: "rfvtgbyhn", value_off: 30, percent_off: true, active: false, merchant_id: 4)
Coupon.create(name: "Fall Sale", code: "qazwsxedc", value_off: 65, percent_off: false, active: true, merchant_id: 5)
Coupon.create(name: "Winter Sale", code: "bgtnhymju", value_off: 25, percent_off: true, active: true, merchant_id: 5)
Coupon.create(name: "Spring Sale", code: "8765ryui", value_off: 15, percent_off: false, active: false, merchant_id: 5)
Coupon.create(name: "Birthday Special", code: "plkmmklp", value_off: 50, percent_off: true, active: true, merchant_id: 5)
Coupon.create(name: "Birthday Special", code: "hghgffjjhghg", value_off: 50, percent_off: true, active: true, merchant_id: 5)