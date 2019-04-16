class ActivityLogsController < ApplicationController
  before_action :activitylogs, only: [:index]
  before_action :new_notifications_count, :notifications_limit, :reports, only: [:index]

  def index;  end
end
