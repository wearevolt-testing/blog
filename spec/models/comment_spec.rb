require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to belong_to(:author).class_name('User') }
  it { is_expected.to belong_to(:commentable) }

  describe '#time_now_if_published_at_is_nil' do
    let!(:time_now) { Time.now.change(usec: 0) }

    context 'when published_at is present' do
      let!(:comment)  { create :comment, published_at: time_now }

      specify do
        expect(Comment.last.published_at).to eq time_now
      end
    end

    context 'when published_at is blank' do
      before { allow(Time).to receive(:now).and_return(time_now) }

      let!(:comment)  { create :comment, published_at: '' }

      specify do
        expect(Comment.last.published_at).to eq time_now
      end
    end
  end

  describe '#comments_for_period' do
    let!(:comment_1) { create :comment, published_at: 2.years.ago }
    let!(:comment_2) { create :comment, published_at: 4.years.ago }

    it 'when period of date is correct' do
      expect(Comment.comments_for_period(5.years.ago, 2.years.ago).size).to eq 2
    end

    it 'when period of date is incorrect' do
      expect(Comment.comments_for_period(2.years.ago, 2.years.ago).size).to eq 0
    end
  end
end
