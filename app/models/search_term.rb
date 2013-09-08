class SearchTerm < ActiveRecord::Base
  validates_uniqueness_of :term
end