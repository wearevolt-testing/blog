require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_length_of(:title).is_at_most(100) }
  it { is_expected.to belong_to(:author).class_name('User') }
  it { is_expected.to have_many(:comments) }

  describe '#recent' do
    let!(:post_1) { create :post }
    let!(:post_2) { create :post }

    it 'should order courses by created_at DESC' do
      expect(Post.recent).to eq [post_2, post_1]
    end
  end

  describe '#posts_for_period' do
    let!(:post_1) { create :post, published_at: 2.years.ago }
    let!(:post_2) { create :post, published_at: 4.years.ago }

    it 'when period of date is correct' do
      expect(Post.posts_for_period(5.years.ago, 2.years.ago).size).to eq 2
    end

    it 'when period of date is incorrect' do
      expect(Post.posts_for_period(2.years.ago, 2.years.ago).size).to eq 0
    end
  end
end
