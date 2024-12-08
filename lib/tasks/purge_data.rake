namespace :purge_data do
  require 'csv'

  desc "Purges the bike and station data for reloading while preserving other db tables"
  task :station_bike => :environment do
    Station.all.each do |station|
      station.destroy
    end
  end

  desc "Purges the product data for reload."
  task :product => :environment do 
    Product.all.each do |station|
      station.destroy
    end
  end
        
end
