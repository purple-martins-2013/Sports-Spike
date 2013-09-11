require 'spec_helper'

describe RedisTrip do

  it { should have_one(:spike) }
  it { should belong_to(:search_term)}
end
