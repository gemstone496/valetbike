class Bike < ApplicationRecord
  validates_presence_of    :identifier
  validates_uniqueness_of  :identifier
  
  belongs_to :current_station, class_name: :Station, foreign_key: :current_station_id, optional: true

  def initialize(row_csv) #from /notes/bike-data.csv
    @identifier = row_csv[0]
    @current_station_id = row_csv[1]
  end
end
