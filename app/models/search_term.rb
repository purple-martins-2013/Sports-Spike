class SearchTerm < ActiveRecord::Base
  has_many :redis_trips
  has_many :events_search_terms
  has_many :events, through: :events_search_terms
  
  validates_uniqueness_of :term
end
