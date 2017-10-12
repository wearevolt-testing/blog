class Api::V1::ReportsController < Api::V1::BaseController
  def by_author
    if params[:start_date].present? && params[:end_date].present? && params[:email].present?
      return render_error 'Date is invalid' unless date_is_valid?
      return render_error 'Period of dates is invalid' unless period_of_dates?

      NewReportsWorker.perform_async(params[:start_date], params[:end_date], params[:email])

      render json: { message: 'Report generation started' }, status: 200
    else
      render_error 'The specified parameters are incorrect'
    end
  end

  private

  def start_date
    DateTime.parse params[:start_date] rescue nil
  end

  def end_date
    DateTime.parse params[:end_date] rescue nil
  end

  def date_is_valid?
    start_date.present? && end_date.present? ? true : false
  end

  def period_of_dates?
    return false unless date_is_valid?

    start_date == end_date ? false : true
  end
end
