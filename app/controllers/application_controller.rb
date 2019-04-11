class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include CommentsHelper
  include NotificationsHelper
  before_action :set_locale
  def reports
    if log_in?
      if admin_user
        @reports_count = Report.where("opened_at IS NULL").order_by_created
        @reports_limit = Report.order_by_created.limit(8)
        @reports = Report.order_by_created
      end
    end
  end

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
      locale : I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
