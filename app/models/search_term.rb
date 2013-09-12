class SearchTerm < ActiveRecord::Base
  has_many :redis_trips

  validates_uniqueness_of :hashtag
end
