require 'spec_helper'

describe Spike do

  it { should validate_presence_of(:peak_velocity)}
  it { should validate_presence_of(:date_time)}

  describe 'with valid information' do
    let(:spike) { create :spike }

    it 'should be valid' do
      expect(spike).to be_valid
    end

  end

end
