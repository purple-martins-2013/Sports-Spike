class Event < ActiveRecord::Base
  has_many :spikes

  validates :name, :date, presence: true
end
