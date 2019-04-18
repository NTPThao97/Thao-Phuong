class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  belongs_to :post_type
  before_save {self.title = title.upcase}
  scope :order_created_at,  -> {order("created_at desc")}
  paginates_per 50
end
