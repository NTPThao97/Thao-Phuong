class Report < ApplicationRecord
  belongs_to :target, class_name: User.name
  belongs_to :des, class_name: User.name
  scope :order_by_created, ->{order created_at: :desc}
  scope :check_opened_at, ->{where "opened_at IS NULL"}
  scope :check_target_id, ->(current_admin){where "target_id != #{current_admin.id}"}
  paginates_per 50
end
