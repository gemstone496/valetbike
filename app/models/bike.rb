class Bike < ApplicationRecord
  validates_presence_of    :identifier
  validates_uniqueness_of  :identifier
  
  belongs_to :current_station, class_name: :Station, foreign_key: :current_station_id, optional: true
  def is_users?(user)
    return false unless user
    user.current_bike_id == id
  end

  def available?
    is_available
  end

  def get_station
     Station.find(current_station_id)
  end

end
