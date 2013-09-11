require 'spec_helper'

describe Event do

  it { should have_and_belong_to_many(:search_terms) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:date) }

  describe 'with valid information' do
    let(:event) { create :event }

    it 'should be valid' do
      expect(event).to be_valid
    end
  end  
end
