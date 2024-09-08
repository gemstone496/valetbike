namespace :load_data do
    require 'csv'

    desc "Reads the bike and station data in from the CSV." 
    #TODO this is probably a bad implementation that doesn't clean the data well. 
    #something something dev left something something Rails Way idk what i'm doing T-T.
    task :load_data => :environment do
        CSV.foreach('notes/bike-data.csv', :headers => true) do |row| #bikes
            Bikes.create!(row.to_hash)
        end
        
        CSV.foreach('notes/station-data.csv', :headers => true) do |row| #stations
            Station.create!(row.to_hash)
        end
    end
end
