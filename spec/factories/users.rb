FactoryGirl.define do
  factory :user do
    name Pinyin.t(Faker::Name.name, splitter: '')
    email Faker::Internet.email
    avatar Faker::Avatar.image
  end
end
