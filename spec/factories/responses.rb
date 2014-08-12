# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :response do
    association :survey
    association :answerer, factory: :user
  end
end
