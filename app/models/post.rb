class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, class_name: Notification.name, foreign_key: :url, dependent: :destroy
  has_many :report, class_name: Report.name, foreign_key: :url, dependent: :destroy
  belongs_to :post_type
  before_save {self.title = title.upcase}
  scope :order_created_at,  -> {order("created_at desc")}
  paginates_per 50

  def self.search(search_post)
    if search_post
      where("title LIKE ?", "%#{search_post.upcase}%").order_created_at
      where("content LIKE ?", "%#{search_post.upcase}%").order_created_at
    else
      order_created_at
    end
  end
end
