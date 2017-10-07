require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(100) }

  it do
    is_expected.to belong_to(:author).
        class_name('User').with_foreign_key('author_id')
  end

  describe '#recent' do
    let!(:post_1) { create :post }
    let!(:post_2) { create :post }

    it 'should order courses by created_at DESC' do
      expect(Post.recent).to eq [post_2, post_1]
    end
  end
end
