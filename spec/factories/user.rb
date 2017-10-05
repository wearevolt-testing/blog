FactoryGirl.define do
  factory :user do
    email    { FFaker::Internet.email }
    nickname { FFaker::Lorem.word }
    password '111111'
  end
end
