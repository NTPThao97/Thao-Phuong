class Notification < ApplicationRecord
  belongs_to :target, class_name: User.name
  belongs_to :des, class_name: User.name
  scope :order_by_created, ->{order created_at: :desc}
  scope :check_des_id, ->(current_user){where "des_id = #{current_user.id}"}
  scope :check_target_id, ->(current_user){where "target_id != #{current_user.id}"}
  scope :check_opened_at, ->{where "opened_at IS NULL" }
  scope :check_status, ->{where "status = true"}
  scope :admin_check_des_id, ->(current_admin){where "des_id = #{current_admin.id}"}
  scope :admin_check_target_type, ->{where "target_type != 'Reported'"}
  scope :admin_check_status, ->{where "status = true"}
  paginates_per 50

  delegate :name, :id, to: :target, prefix: true, allow_nil: true
  delegate :name, :id, to: :des, prefix: true, allow_nil: true


end
