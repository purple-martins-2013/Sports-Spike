# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    sequence(:name) { |n| "Event #{n}" }
    sequence(:date) { |n| Time.now + n }
  end

  factory :search_term do
    sequence(:hashtag) { |n| "Hashtag#{n}" }

    factory :search_term_with_events do
      events { [create(:event)] }

      ignore do
        redis_trip_count 30
      end

      after(:create) do |search_term, evaluator|
        create_list(:redis_trip, evaluator.redis_trip_count, search_term: search_term)
      end
    end
  end

  factory :spike do
    redis_trip
  end

  factory :redis_trip do
    tweet_count { rand(4) == 3 ? 400 : 50 }
  end
end
