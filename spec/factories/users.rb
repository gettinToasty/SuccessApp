FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    password { Faker::Internet.password(10) }

    factory :short_password_user do
      password { Faker::Internet.password(4) }

    end

    sequence :goals do
      [FactoryGirl.build(:goal),
      FactoryGirl.build(:complete_goal),
      FactoryGirl.build(:private_goal)]
    end
  end
end
