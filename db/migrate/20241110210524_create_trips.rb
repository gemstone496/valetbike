class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.integer :bike_id
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :end_station_id

      t.timestamps
    end
  end
end
