require 'spec_helper'

describe Spike do

  it { should validate_presence_of(:peak_velocity) }
  it { should validate_presence_of(:date_time) }
  # TODO : test presence of event association
  it { should belong_to (:event) }

  describe 'with valid information' do
    let(:spike) { create :spike }

    it 'should be valid' do
      expect(spike).to be_valid
    end
  end

  describe 'Spike#time_since_game_start' do
    time = Time.now
    let!(:spike) { create :spike, date_time: time + 100}
    
    before do
      spike.event.date = time
      spike.event.save
    end

    it 'should return the correct time in seconds' do
      expect(spike.date_time.time - spike.event.date.time).to eq 100
    end

  end

end
