FactoryGirl.define do
  factory :question do
    text { Faker::Lorem.sentence() + "?" }
    kind { :text }


    factory :question_with_variants do
      kind { [:check, :radio].sample }
    end
    factory :question_without_variants do
      kind { [:text].sample }
    end
  end
end
