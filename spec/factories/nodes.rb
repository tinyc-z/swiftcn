FactoryGirl.define do
  factory :node do
    name  { Faker::Name.name }
  end
end
