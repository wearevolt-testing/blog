require 'rails_helper'

RSpec.describe NewReportsWorker, type: :worker do
  it 'should to check the start of the worker' do
    NewReportsWorker.perform_async(5.years.ago, 2.years.ago, 'example@example.co')
    expect(NewReportsWorker.jobs.size).to eq 1
  end
end
