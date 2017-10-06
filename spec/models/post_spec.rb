require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :title }

  it do
    is_expected.to belong_to(:author).
        class_name('User').with_foreign_key('author_id')
  end
end
