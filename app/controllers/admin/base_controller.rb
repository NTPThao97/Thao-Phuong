class Admin::BaseController < ApplicationController
  layout "admin/application"
  protect_from_forgery with: :exception
  include Admin::NotificationsHelper
  include Admin::SessionsHelper
  before_action :set_locale, :admin_check_log_in, :load_decentralizations
  before_action :new_notifications_count, :notifications_limit, :reports
  def reports
    if log_in?
      @reports_count = Report.where("opened_at IS NULL").where("target_id != #{current_admin.id}").order_by_created
      @reports_limit = Report.where("target_id != #{current_admin.id}").order_by_created.limit(8)
      @reports = Report.order_by_created.page(params[:page]).per(2)
    end
  end

  def load_decentralizations
    @decentralizations = Decentralization.select("decentralizations.*, count(users.id) as number_account").joins("inner JOIN users on decentralizations.id = users.user_type").group("users.user_type")
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
