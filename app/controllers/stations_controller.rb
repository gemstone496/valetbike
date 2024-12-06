class StationsController < ApplicationController
  
  def index
    @user = get_user_info_from_session
    unless @user&.current_trip_id.nil?
      @trip = Trip.find(@user.current_trip_id)
    end
    Station.find_by(name: "State St/Mass Central Rail Trail").update(address: "298 State St Northampton MA")
    @stations = Station.all.order(identifier: :asc)
    @lats = Array.new # array of latitudes
    @longs = Array.new # array of longitudes
    @names = Array.new # station names
    @ids = Array.new # station ids
    @addresses = Array.new # REYFUCKS UP
    @bikes = Array.new # REYFUCKS UP
    @userid = @user&.id.present? || false #does the user id exist?
    @tripid = @user&.current_trip_id.present? || false #does trip id exist?
    @iduser = @user&.id #user id
    @idtrip = @user&.current_trip_id #trip id
    # sorry for the terrible naming

    @stations.each do |s|
      if s.latitude && s.longitude then  # block when geocode fails
        @lats.append(s.latitude)
        @longs.append(s.longitude)
        @names.append(s.name)
        @ids.append(s.identifier)
        @addresses.append(s.address) #REYFUCKS UP
        @bikes.append(Bike.where(current_station_id: s.id).length) #REYFUCKS UP
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
