class UpdateReportService
attr_accessor :report

  def initialize params
    @report = Report.find_by(id: params[:report_id])
  end

  def perform
    report.update! opened_at: Time.current
    true
  rescue StandardError
    false
  end

end
