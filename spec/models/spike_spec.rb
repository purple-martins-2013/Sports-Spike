require 'spec_helper'

describe Spike do

  let(:term) { create :search_term, id: 28, hashtag: "#49ers" }
  let(:trip) { create :redis_trip, search_term: term }
  let(:spike) { create :spike, redis_trip: trip }

  it { should belong_to(:redis_trip) }

  describe 'with valid information' do

    it 'should be valid' do
      expect(spike).to be_valid
    end

    it 'should have an associated search_term' do 
      expect(spike.redis_trip.search_term.hashtag).to eq "#49ers"
    end

    it 'should have a game status' do
      expect(spike.game_status).to_not be_nil
    end
  end
end
