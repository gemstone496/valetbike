namespace :load_data do
  require 'csv'

  desc "Reads the station data in from the CSV."
  task :station => :environment do
    CSV.foreach('notes/station-data.csv', :headers => true) do |row| #stations
      station = Station.create(identifier: row[0], 
                                      name: row[1], 
                                      address: row[6])
    end
  end

  desc "Reads the bike data in from the CSV." 
  task :bike => :environment do

    CSV.foreach('notes/bike-data.csv', :headers => true) do |row| #bikes
      station = Station.find_by(identifier: row[1])
      bike = Bike.create(identifier: row[0], current_station: station)
      bike.current_station_id = station != nil ? station.id : nil
      bike.save

    end
  end

  desc "Read the plan pricing data from the CSV."
  task :product => :environment do 
    CSV.foreach('notes/plan-data.csv', :headers => true) do |row| #product
      product = Product.create(name: row[0], price: row[1], desc: row[2])

    end

  end
        
end
