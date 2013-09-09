class Event < ActiveRecord::Base
  has_many :events_search_terms
  has_many :search_terms, through: :events_search_terms

  validates :name, :date, presence: true
end
