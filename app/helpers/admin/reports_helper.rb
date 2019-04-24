module Admin::ReportsHelper
  def reports_count
    @reports_count = Report.check_opened_at.check_target_id(current_admin).order_by_created
  end
  def reports_limit
    @reports_limit = Report.check_target_id(current_admin).order_by_created.limit(8)
  end
  def reports
    @reports = Report.order_by_created.page(params[:page]).per(2)
  end
end
