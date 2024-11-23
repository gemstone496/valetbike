class AddStartStationToTrip < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :start_station_is, :integer
  end
end
