class NewReportsWorker
  include Sidekiq::Worker

  sidekiq_options retry: true, failure: true

  def perform(report, recipient_email, start_date, end_date)
    ReportsMailer.new_report_by_author(report, recipient_email, start_date, end_date).deliver
  end
end
