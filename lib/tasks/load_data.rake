namespace :load_data do
    require 'csv'

    desc "Reads the bike and station data in from the CSV." 
    #TODO this is probably a bad implementation that doesn't clean the data well. 
    #something something dev left something something Rails Way idk what i'm doing.
    task :bike => :environment do
        CSV.foreach('/home/jadelilian/valetbike/notes/bike-data.csv', :headers => true) do |row| #bikes
            Bike.create(:identifier => row[0], :current_station_id => row[1])
        end
    end
        
    task :station => :environment do
        CSV.foreach('/home/jadelilian/valetbike/notes/station-data.csv', :headers => true) do |row| #stations
            Station.create(:identifier => row[0], :name => row[1], :address => row[6])
        end
    end
end
