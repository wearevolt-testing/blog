require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :nickname }
  it { is_expected.to validate_length_of(:nickname).is_at_most(39) }
  it { is_expected.to have_many(:posts).with_foreign_key('author_id') }
  it { is_expected.to have_many(:comments).with_foreign_key('author_id') }

  describe 'unique validation for nickname' do
    subject { create :user }
    it { is_expected.to validate_uniqueness_of(:nickname).ignoring_case_sensitivity }
  end

  describe 'destoys dependent posts' do
    let!(:posts) { create(:user, :several_posts) }

    specify do
      expect { User.last.destroy }.to change { Post.count }.by(-2)
    end
  end

  describe 'destoys dependent comments' do
    let!(:author) { create :user, :several_comments }

    specify do
      expect { User.last.destroy }.to change { Comment.count }.by(-2)
    end
  end

  describe '#ensure_authentication_token' do
    context 'generate a unique token' do
      let!(:user) { build :user }

      before do
        allow(Devise).to receive(:friendly_token).and_return('uniquetoken123')
        user.save!
      end

      specify do
        expect(user.authentication_token).to eq 'uniquetoken123'
      end
    end
  end

  describe '#nickname_downcase' do
    let!(:user_1) { create :user, nickname: 'nickname' }
    let!(:user_2) { build :user, nickname: 'Nickname' }

    specify do
      expect(user_2).to_not be_valid
    end
  end
end
