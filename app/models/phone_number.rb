class PhoneNumber < ActiveRecord::Base
  has_and_belongs_to_many :search_terms

  validates :number, presence: true
end