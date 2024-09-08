namespace :load_data do
    require 'csv'

    desc "Reads the bike and station data in from the CSV." 
    #TODO this is probably a bad implementation that doesn't clean the data well. 
    #something something dev left something something Rails Way idk what i'm doing.

    path = '/home/jadelilian/valetbike/notes/'
    task :bike => :environment do
        CSV.foreach(path + 'bike-data.csv', :headers => true) do |row| #bikes
            Bike.new(row)
        end
    end
        
    task :station => :environment do
        CSV.foreach(path + 'station-data.csv', :headers => true) do |row| #stations
            Station.new(row)
        end
    end
end
