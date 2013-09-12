class SearchTerm < ActiveRecord::Base
  has_many :redis_trips
  has_and_belongs_to_many :events
  has_and_belongs_to_many :phone_numbers
  
  validates_uniqueness_of :hashtag
end
