class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, class_name: Notification.name, foreign_key: :url, dependent: :destroy
  has_many :report, class_name: Report.name, foreign_key: :url, dependent: :destroy
  belongs_to :post_type
  before_save {self.title = title.upcase}
  scope :order_created_at,  -> {order("created_at desc")}
  paginates_per 50

  def self.search(post_type_id)
    if post_type_id
      where(post_type_id: post_type_id).order_created_at
    else
      order_created_at
    end
  end
end
