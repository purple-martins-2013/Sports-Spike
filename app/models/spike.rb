class Spike < ActiveRecord::Base
  belongs_to :event
  
  validates :peak_velocity, :date_time, :event, presence: true

end
