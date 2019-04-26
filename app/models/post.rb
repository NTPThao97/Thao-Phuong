class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, class_name: Notification.name, foreign_key: :url, dependent: :destroy
  has_many :report, class_name: Report.name, foreign_key: :url, dependent: :destroy
  belongs_to :post_type
  before_save {self.title = title.upcase}
  scope :order_created_at,  -> {order("created_at desc")}
  paginates_per 50
  enum status: {public: 1, private: 2, only_me: 3}, _prefix: :status

  def self.search_type(post_type_id)
    if post_type_id
      where(["post_type_id LIKE ?", "%#{post_type_id}%"]).where("status = 1 or status = 2").order_created_at
    else
      nil
    end
  end
  def self.search_post(search_post)
    if search_post
      where("title LIKE ?", "%#{search_post}%").where("status = 1 or status = 2").order_created_at
    else
      nil
    end
  end
  def self.posts user
    following_ids =  Relationship.select("followed_id").following(user)
    where("user_id = #{user.id} or status = 1 or (status = 2 and user_id IN (#{following_ids.to_sql}))").order_created_at
  end
end
