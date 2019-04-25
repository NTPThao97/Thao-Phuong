class Admin::BaseController < ActionController::Base
  layout "admin/application"
  protect_from_forgery with: :exception
  include Admin::NotificationsHelper
  include Admin::SessionsHelper
  include Admin::ReportsHelper
  before_action :set_locale, :admin_check_log_in
  before_action :new_notifications_count, :notifications_limit
  before_action :reports_count, :reports_limit

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
