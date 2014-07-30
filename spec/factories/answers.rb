FactoryGirl.define do
  factory :answer do
    text { Faker::Lorem.sentence }
    association :answerer, factory: :user
    association :question, factory: :question
  end
end
