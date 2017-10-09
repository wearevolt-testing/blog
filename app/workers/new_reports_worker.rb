class NewReportsWorker
  include Sidekiq::Worker

  def perform(json, recipient_email, start_date, end_date)
    ReportsMailer.new_report_by_author(json, recipient_email, start_date, end_date).deliver
  end
end
