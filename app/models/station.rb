class Station < ApplicationRecord  
  validates_presence_of    :identifier,
                           :name,
                           :address
  validates_uniqueness_of  :identifier
  
  has_many :docked_bikes, class_name: :Bike, foreign_key: :current_station_id

  attribute :latitude, type: Float
  attribute :longitude, type: Float

  geocoded_by :address
  after_validation :geocode
end
