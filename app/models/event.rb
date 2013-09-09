class Event < ActiveRecord::Base
  has_and_belongs_to_many :search_terms

  validates :name, :date, presence: true
end
