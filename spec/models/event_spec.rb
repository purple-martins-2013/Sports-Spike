require 'spec_helper'

describe Event do

  it { should have_many(:spikes) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:date) }
end
