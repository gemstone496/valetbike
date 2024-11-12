class GeocodeStations < ActiveRecord::Migration[7.0]
  def change
    add_column :stations, :lat, :double
    add_column :stations, :long, :double
  end
end
