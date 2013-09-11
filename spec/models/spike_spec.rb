require 'spec_helper'

describe Spike do

  it { should belong_to(:redis_trip) }

  describe 'with valid information' do
    let(:spike) { create :spike }

    it 'should be valid' do
      expect(spike).to be_valid
    end
  end
end
