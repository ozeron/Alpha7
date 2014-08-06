# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shared_link do
    key { Faker::Number.number(10) }
    association :survey
  end
end
