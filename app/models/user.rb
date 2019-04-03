class User < ApplicationRecord
  before_save {self.email = email.downcase}
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :active_relations, class_name: "Relation",
                                                  foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relations, class_name: "Relation",
                                                  foreign_key: :followed_id, dependent: :destroy
  has_many :notifications, class_name: "Notification",
                                                  foreign_key: :target_id, dependent: :destroy
  has_many :following, through: :active_relations , source: :followed
  has_many :followers ,through: :passive_relations, source: :follower
  has_one_attached :avatar
  has_secure_password
  validates :name , presence: true , length: {minimum: 5}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true , uniqueness: true,
  format: {with: VALID_EMAIL_REGEX}
  validates :password, length: {minimum: 8, maximum: 20}, allow_nil: true

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
    end

  def create_password_reset_digest
    self.password_reset_token = User.new_token
    update_columns reset_digest: User.digest(password_reset_token)
    update_columns reset_send_at: Time.zone.now
  end
end
