FactoryGirl.define do
  factory :topic do
    title Faker::Lorem.sentence 
    body_original Faker::Lorem.paragraph
    user_id {FactoryGirl.create(:user).id}
    node_id {FactoryGirl.create(:node).id}
  end
end
