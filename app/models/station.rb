class Station < ApplicationRecord
  validates_presence_of    :identifier,
                           :name,
                           :address
  validates_uniqueness_of  :identifier
  
  has_many :docked_bikes, class_name: :Bike, foreign_key: :current_station_id

  def initialize(row_csv) #from /notes/station-data.csv
    @identifier = row_csv[0]
    @name = row_csv[1]
    @address = row_csv[6]
  end
end
