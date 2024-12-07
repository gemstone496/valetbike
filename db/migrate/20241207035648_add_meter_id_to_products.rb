class AddMeterIdToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :meter_id, :string
  end
end
