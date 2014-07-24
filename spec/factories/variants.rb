# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :variant do
    text {Faker::Lorem.sentence }
    association :question, factory: :question_with_variants
  end
end
