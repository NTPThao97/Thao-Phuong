class Comment< ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  has_many :replies, class_name: "Comment", foreign_key: :comment_id, dependent: :destroy

  acts_as_tree order: 'created_at DESC'
end
