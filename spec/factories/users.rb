FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthday {  rand(18.year..50.year).ago }
    gender {[:male, :female, :other].sample }

    factory :admin do
      role { :admin }
    end
  end


end
