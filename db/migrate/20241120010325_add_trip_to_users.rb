class AddTripToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :current_trip_id, :integer
  end
end
