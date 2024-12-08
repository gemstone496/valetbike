class AddMeterEventToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :meter_event, :string
  end
end
