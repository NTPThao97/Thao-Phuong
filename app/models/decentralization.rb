class Decentralization < ApplicationRecord
  has_many :users, dependent: :destroy
end
