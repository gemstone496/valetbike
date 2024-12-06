class AddCodeToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :code, :integer
  end
end
