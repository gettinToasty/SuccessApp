FactoryGirl.define do
  factory :goal do
    private "PUBLIC"
    status "INCOMPLETE"
    description { "#{Faker::Hacker.verb} #{Faker::Hacker.adjective} #{Faker::Hacker.noun}" }

    factory :private_goal do
      private "PRIVATE"
    end

    factory :complete_goal do
      status "COMPLETE"
    end
  end
end
