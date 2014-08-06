# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey do
    title { Faker::Lorem.sentence }
    private { false }
    association :user, factory: :user
  end
end
