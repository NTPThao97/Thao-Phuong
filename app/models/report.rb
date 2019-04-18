class Report < ApplicationRecord
  belongs_to :target, class_name: User.name
  belongs_to :des, class_name: User.name
  scope :order_by_created, (->{order created_at: :desc})
  paginates_per 50
end
