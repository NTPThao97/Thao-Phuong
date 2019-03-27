class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  belongs_to :post_type
  before_save {self.title = title.upcase}
end
