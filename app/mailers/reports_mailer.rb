class ReportsMailer < ApplicationMailer
  def new_report_by_author(report, recipient_email, start_date, end_date)
    @report = report
    @start_date = start_date
    @end_date = end_date

    mail(to: recipient_email, subject: 'New report')
  end
end
