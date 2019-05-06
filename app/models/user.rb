class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save {self.email = email.downcase}
  before_create :create_activation_digest

  belongs_to :decentralization, optional: true

  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :reports, class_name: Report.name, foreign_key: :url, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name, foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name, foreign_key: :followed_id, dependent: :destroy
  has_many :notifications, class_name: Notification.name, foreign_key: :des_id, dependent: :destroy
  has_many :following, through: :active_relationships , source: :followed
  has_many :followers ,through: :passive_relationships, source: :follower
  has_one_attached :avatar

  has_secure_password
  paginates_per 50
  validates :name , presence: true , length: {minimum: 5}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true , uniqueness: true,
  format: {with: VALID_EMAIL_REGEX}
  validates :password, length: {minimum: 8, maximum: 20}, allow_nil: true
  enum status: {online: 1, offline: 2, unactived: 3, blocked: 4}, _prefix: :status
  enum user_type: [:admin, :user]

  scope :order_created_at, ->{order(created_at: :desc)}
  scope :search_user, ->(search){where("name LIKE '%#{search}%'")}

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

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def create_password_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_digest
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def follow (orther_user)
    following << orther_user
  end

  def unfollow(orther_user)
    following.delete orther_user
  end

  def following?(orther_user)
    following.include?(orther_user)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def posts_home
    Post.status_private.where('posts.user_id IN (?)', following.pluck(:id).join(',')).or(Post.status_public).order_created_at
  end
end
