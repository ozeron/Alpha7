FactoryGirl.define do
  factory :answer do
    text { Faker::Lorem.sentence }
    association :response
    association :question
  end
end
