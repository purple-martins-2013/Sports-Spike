require 'spec_helper'

describe RedisTrip do
  let(:term) { create :search_term }

  it { should have_one(:spike) }
  it { should belong_to(:search_term)}

  describe 'populate_algorithm_fields' do
    
    context 'before SHORT_EMA_PERIOD RedisTrips' do

      before do
        ( RedisTrip::SHORT_EMA_PERIOD - 1 ).times do 
          create :redis_trip, tweet_count: 50, search_term: term
        end
      end

      it 'should not fill in any fields' do
        redis_trip = create :redis_trip, search_term: term
        expect(redis_trip.short_ema).to   be_nil
        expect(redis_trip.long_ema).to    be_nil
        expect(redis_trip.macd).to        be_nil
        expect(redis_trip.signal_line).to be_nil
        expect(redis_trip.histogram).to   be_nil
      end
    end

    context 'at SHORT_EMA_PERIOD RedisTrips' do

      before do
        ( RedisTrip::SHORT_EMA_PERIOD ).times do
          create :redis_trip, tweet_count: 50, search_term: term
        end
      end

      it 'should fill in short_ema' do
        redis_trip = create :redis_trip, search_term: term
        expect(redis_trip.short_ema).to_not be_nil
      end

      it 'should not fill in long_ema, macd, signal_line, histogram' do
        redis_trip = create :redis_trip, search_term: term
        expect(redis_trip.long_ema).to    be_nil
        expect(redis_trip.macd).to        be_nil
        expect(redis_trip.signal_line).to be_nil
        expect(redis_trip.histogram).to   be_nil
      end
    end

    context 'at LONG_EMA_PERIOD RedisTrips' do

      before do
        ( RedisTrip::LONG_EMA_PERIOD ).times do
          create :redis_trip, tweet_count: 50, search_term: term
        end
      end

      it 'should fill in long_ema and macd' do
        redis_trip = create :redis_trip, search_term: term
        expect(redis_trip.long_ema).to_not be_nil
        expect(redis_trip.macd).to_not     be_nil
      end

      it 'should not fill in signal_line or histogram' do
        redis_trip = create :redis_trip, search_term: term
        expect(redis_trip.signal_line).to be_nil
        expect(redis_trip.histogram).to   be_nil
      end
    end

    context 'at SIGNAL_LINE_PERIOD + LONG_EMA_PERIOD RedisTrips' do

      before do
        ( RedisTrip::LONG_EMA_PERIOD + RedisTrip::SIGNAL_LINE_PERIOD ).times do
         create :redis_trip, tweet_count: 50, search_term: term 
        end
      end

      it 'should fill in signal line and histogram' do
        redis_trip = create :redis_trip, search_term: term
        expect(redis_trip.signal_line).to_not be_nil
        expect(redis_trip.histogram).to_not   be_nil
      end
    end
  end

  describe 'calculate_short_ema' do

    context 'at SHORT_EMA_PERIOD RedisTrips' do

      before do
        ( RedisTrip::SHORT_EMA_PERIOD ).times do
          create :redis_trip, tweet_count: 50, search_term: term
        end
      end

      it 'should successfully calculate new short_ema from previous tweet_counts' do
        redis_trip = create :redis_trip, search_term: term
        expect(redis_trip.short_ema).to eq 50
      end
    end

    context 'past SHORT_EMA_PERIOD RedisTrips' do

      before do
        ( RedisTrip::SHORT_EMA_PERIOD + 1 ).times do
          create :redis_trip, tweet_count: 50, search_term: term
        end
      end

      it 'should successfully calculate new short_ema from previous short_ema' do
        redis_trip = create :redis_trip, search_term: term
        expect(redis_trip.short_ema).to eq 50
      end
    end
  end

  describe 'calculate_long_ema' do

    context 'at LONG_EMA_PERIOD RedisTrips' do

      before do
        ( RedisTrip::LONG_EMA_PERIOD ).times do
          create :redis_trip, tweet_count: 50, search_term: term
        end
      end

      it 'should successfully calculate new long_ema from previous tweet_count'do
        redis_trip = create :redis_trip, search_term: term
        expect(redis_trip.long_ema).to eq 50
      end
    end

    context 'past SHORT_EMA_PERIOD RedisTrips' do

      before do
        ( RedisTrip::LONG_EMA_PERIOD + 1 ).times do
          create :redis_trip, tweet_count: 50, search_term: term
        end 
      end

      it 'should successfully calculate new long_ema from previous long_ema' do
        redis_trip = create :redis_trip, tweet_count: 50, search_term: term
        expect(redis_trip.long_ema).to eq 50
      end
    end
  end

  describe 'calculate_macd' do

    before do
      (RedisTrip::LONG_EMA_PERIOD).times do
        create :redis_trip, tweet_count: 50, search_term: term
      end
    end

    it 'should successfully calculate macd from long_ema and short_ema' do
      redis_trip = create :redis_trip, tweet_count: 50, search_term: term
      expect(redis_trip.macd).to eq 0
    end
  end

  describe 'calculate_signal_line' do

    context 'at LONG_EMA_PERIOD + SIGNAL_LINE_PERIOD RedisTrips' do

      before do
        (RedisTrip::LONG_EMA_PERIOD).times do
          create :redis_trip, tweet_count: 50, search_term: term
        end
        (RedisTrip::SIGNAL_LINE_PERIOD).times do
          create :redis_trip, tweet_count: 100, search_term: term
        end
      end

      it 'should successfully calculate signal_line from macd and previous macds' do
        redis_trip = create :redis_trip, tweet_count: 100, search_term: term
        expect(redis_trip.signal_line).to eq 20 #this is hardcoded in and will fail with changes.  Refactor to make resilient
      end
    end

    context 'past LONG_EMA_PERIOD + SIGNAL_LINE_PERIOD RedisTrips' do

      before do
        (RedisTrip::LONG_EMA_PERIOD).times do
          create :redis_trip, tweet_count: 50, search_term: term
        end
        (RedisTrip::SIGNAL_LINE_PERIOD + 1 ).times do
          create :redis_trip, tweet_count: 100, search_term: term
        end
      end

      it 'should successfully calculate signal_line from previous macds' do
        redis_trip = create :redis_trip, tweet_count: 100, search_term: term
        expect(redis_trip.signal_line).to eq 18 #this is hardcoded in
      end
    end
  end

  describe 'histogram' do

    before do
      (RedisTrip::LONG_EMA_PERIOD).times do
        create :redis_trip, tweet_count: 50, search_term: term
      end
      (RedisTrip::SHORT_EMA_PERIOD).times do
        create :redis_trip, tweet_count: 100, search_term: term
      end
    end

    it 'should successfully calculate histogram' do
      redis_trip = create :redis_trip, tweet_count: 100, search_term: term
      expect(redis_trip.histogram).to eq -1 #hardcoded in
    end
  end
end
