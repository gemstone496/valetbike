class GeocodeStations < ActiveRecord::Migration[7.0]
  def change
    add_column :stations, :latitude, :double
    add_column :stations, :longitude, :double
  end
end
