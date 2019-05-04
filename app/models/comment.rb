class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  acts_as_tree order: "created_at DESC"
  has_many :comment_replies, class_name: Comment.name, foreign_key: :parent_id, dependent: :destroy
end
