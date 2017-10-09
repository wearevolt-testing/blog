class ReportsMailer < ApplicationMailer
  def new_report_by_author(json, recipient_email, start_date, end_date)
    @hash = JSON.parse(json).to_h
    @start_date = start_date
    @end_date = end_date

    mail(to: recipient_email, subject: 'New report')
  end
end
