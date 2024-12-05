class StationsController < ApplicationController
  
  def index
    @stations = Station.all.order(identifier: :asc)
    @user = get_user_info_from_session
    @uCoords = Geocoder.search(request.ip).first.coordinates

    @lats = Array.new # array of latitudes
    @longs = Array.new # array of longitudes
    @names = Array.new # station names
    @ids = Array.new # station ids
    @stations.each do |s|
      if s.latitude && s.longitude then  # block when geocode fails
        @lats.append(s.latitude)
        @longs.append(s.longitude)
        @names.append(s.name)
        @ids.append(s.id)
      end
    end
  end

  def show
    @user = get_user_info_from_session
    @station = Station.find(params[:id])
    if @user
    unless @user.current_trip_id.nil?
      @trip = Trip.find(@user.current_trip_id)
    end
    end
  end
  
end
