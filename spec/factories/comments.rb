FactoryGirl.define do
  factory :comment do
    body { Faker::Hacker.say_something_smart }

    factory :invalid_comment do
      body ""
    end
  end
end
