# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    sequence(:name) { |n| "Event #{n}" }
    sequence(:date) { |n| Date.today + n }

    factory :event_with_spikes do
      ignore do
        spikes_count 5
      end

      after(:create) do |event, evaluator|
        create_list(:spike, evaluator.events_count, event: event)
      end
    end
  end

  factory :spike do
    sequence(:date_time) { |n| Time.now + n * 3600 }
    peak_velocity { rand(100) * 10 }
    event
  end
end
