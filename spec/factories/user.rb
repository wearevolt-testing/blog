FactoryGirl.define do
  factory :user do
    email    { FFaker::Internet.email }
    nickname { FFaker::Name.unique.name }
    password '111111'

    trait :several_posts do
      before(:create) do |user|
        user.posts = create_list :post, 2
      end
    end

    trait :several_comments do
      before(:create) do |user|
        user.comments = create_list :comment, 2
      end
    end
  end
end
