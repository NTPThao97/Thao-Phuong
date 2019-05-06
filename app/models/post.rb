class Post < ApplicationRecord
  before_save {self.title = title.upcase}

  belongs_to :user
  belongs_to :post_type

  has_many :comments, dependent: :destroy
  has_many :notifications, class_name: Notification.name, foreign_key: :url, dependent: :destroy
  has_many :reports, class_name: Report.name, foreign_key: :url, dependent: :destroy
  has_many_attached :images

  validates :title, length: {minimum: 5, maximum: 200}
  enum status: {public: 1, private: 2, only_me: 3}, _prefix: :status
  paginates_per 50

  scope :order_created_at, ->{order(created_at: :desc)}
  scope :check_status, ->{where("posts.status IN (1,2)")}
  scope :order_status, ->{order(status: :desc)}
  scope :check_current_user, ->(current_user){where(user_id: current_user.id)}
end
