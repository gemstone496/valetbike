class StationsController < ApplicationController
  
  def index
    @stations = Station.all.order(identifier: :asc)
    @lats = Array.new # array of latitudes
    @longs = Array.new # array of longitudes
    @stations.each do |s|
      puts s.latitude 
      @lats.append(s.latitude)
      @longs.append(s.longitude)
    end
  end

  def show
    @user = get_user_info_from_session
    @station = Station.find(params[:id])
    @trip = Trip.find(params[:id])
  end
  
end
