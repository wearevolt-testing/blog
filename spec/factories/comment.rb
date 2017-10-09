FactoryGirl.define do
  factory :comment do
    body         { FFaker::Lorem.paragraph }
    published_at { Time.now }

    association :author, factory: :user

    before(:create) do |comment|
      comment.commentable = create(:post)
    end
  end
end
