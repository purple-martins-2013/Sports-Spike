class SearchTerm < ActiveRecord::Base
  has_many :redis_trips
  has_and_belongs_to_many :events

  
  validates_uniqueness_of :hashtag
end
