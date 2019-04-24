class Decentralization < ApplicationRecord
  scope :order_created_at, ->{order "created_at desc" }
end
