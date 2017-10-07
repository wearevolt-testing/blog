FactoryGirl.define do
  factory :comment do
    body { FFaker::Lorem.paragraph }

    association :author, factory: :user

    before(:create) do |comment|
      comment.commentable = create(:post)
    end
  end
end
