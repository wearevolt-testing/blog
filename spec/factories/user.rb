FactoryGirl.define do
  factory :user do
    email    { FFaker::Internet.email }
    nickname { FFaker::Lorem.word }
    password '111111'

    trait :second_posts do
      before(:create) do |user|
        user.posts = create_list :post, 2
      end
    end
  end
end
