class CouponSerializer
    include JSONAPI::Serializer
    attributes :name, :code, :value_off, :percent_off, :active
end
  