class AddAvailablility < ActiveRecord::Migration[7.0]
  def change
    add_column :bikes, :is_available, :boolean, :default => true
  end
end
