class AddSubscriptionIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :subscription_id, :string
  end
end
