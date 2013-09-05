require 'spec_helper'

describe Spike do

  it { should validate_presence_of(:peak_velocity)}
  it { should validate_presence_of(:date_time)}

end
