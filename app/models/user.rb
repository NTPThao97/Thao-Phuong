class User < ApplicationRecord
  before_save {self.email = email.downcase}
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :active_relations, class_name: "Relation",
                                                  foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relations, class_name: "Relation",
                                                  foreign_key: :followed_id, dependent: :destroy
  has_many :active_notices, class_name: "PeopleNotice",
                                                  foreign_key: :noti_user_id, dependent: :destroy
  has_many :passive_notices, class_name: "PeopleNotice",
                                                  foreign_key: :re_user_id, dependent: :destroy
  has_many :following, through: :active_relations , source: :followed
  has_many :followers ,through: :passive_relations, source: :follower
  has_many :replies, through: :active_notices, source: :re_user
  has_many :notices, through: :active_notices, source: :noti_user
  validates :name , presence: true , length: {minimum: 5}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true , uniqueness: true,
  format: {with: VALID_EMAIL_REGEX}
  validates :password, length: {minimum: 8, maximum: 20}, allow_nil: true
end
