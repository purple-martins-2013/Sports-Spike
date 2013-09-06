require 'spec_helper'

describe RedisTrip do

  it { should validate_presence_of(:time) }

  describe 'RedisTrip::time_between_last_two_trips' do
    time = Time.now
    let!(:first_trip) { create :redis_trip, time: time  }
    let!(:second_trip) { create :redis_trip, time: time + 100 }

    
    it 'should equal the time between two trips' do
      expect(RedisTrip.time_between_last_two_trips).to eq 100
    end
  end

end
