# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spike do
    sequence(:date_time) { |n| Time.now + n * 3600 }
    peak_velocity { rand(100) * 10 }
  end
end
