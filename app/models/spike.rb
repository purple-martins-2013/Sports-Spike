class Spike < ActiveRecord::Base
  validates :peak_velocity, :date_time, presence: true

end
