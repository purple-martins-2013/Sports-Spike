# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  to_create {|instance| instance.save }

  factory :event do
    sequence(:name) { |n| "Event #{n}" }
    sequence(:date) { |n| Time.now + n }
  end

  factory :search_term do
    sequence(:hashtag) { |n| "Hashtag#{n}" }

    factory :search_term_with_events do
      events { [create(:event)] }

      ignore do
        redis_trip_count 35
      end

      after(:create) do |search_term, evaluator|
        create_list(:redis_trip, evaluator.redis_trip_count, search_term: search_term)
      end
    end
  end

  factory :spike do
    redis_trip { create(:redis_trip) }
  end

  factory :redis_trip do
    tweet_count { rand(7) == 3 ? 400 : 50 }
    search_term
  end
end
