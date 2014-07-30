FactoryGirl.define do
  factory :question do
    text { Faker::Lorem.sentence() + "?" }
    kind { :text }
    association :survey, factory: :survey

    factory :question_with_variants do
      kind { [:check, :radio, :scale].sample }
    end
    factory :question_without_variants do
      kind { [:label, :text, :paragraph].sample }
    end
  end
end
