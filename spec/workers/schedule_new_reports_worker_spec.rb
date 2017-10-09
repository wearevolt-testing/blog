require 'rails_helper'

RSpec.describe ScheduleNewReportsWorker, type: :worker do
  it 'should to check the start of the worker' do
    ScheduleNewReportsWorker.perform_async(5.years.ago, 2.years.ago, 'example@example.co')
    expect(ScheduleNewReportsWorker.jobs.size).to eq 1
  end
end
