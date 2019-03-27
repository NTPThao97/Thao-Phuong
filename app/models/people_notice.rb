class PeopleNotice < ApplicationRecord
  belongs_to :noti_user, class_name: "User"
  belongs_to :re_user, class_name: "User"
  belongs_to :notification
end
