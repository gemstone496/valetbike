class AddBikeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :current_bike_id, :integer
  end
end
