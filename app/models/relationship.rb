class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  scope :following, ->(user){where(follower_id: user.id)}
end
