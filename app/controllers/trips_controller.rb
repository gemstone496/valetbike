class TripsController < ApplicationController
  def new
    @trip = Trip.new
    @bike = Bike.find(params[:bike_id])
    @station = Station.find(params[:station_id])
    @user = User.find(params[:user_id])
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      @bike = Bike.find(@trip.bike_id)
      @station = Station.find(@trip.start_station_is)
      @user = User.find(@trip.user_id)
      @user.update(current_trip_id: @trip.id)
      @bike.update(is_available: false, current_station_id: nil)
      redirect_to confirm_path(trip_id: @trip.id)
    else
      render :new
    end
  end
  def show
    @trip = Trip.find(params[:trip_id])
  end

  def confirmation
     @trip = Trip.find(params[:trip_id])
  end

  def end_confirmation
    @trip = Trip.find(params[:trip_id])
    @user = User.find(@trip.user_id)
    @bike = Bike.find(@trip.bike_id)
    @user.update(current_trip_id: nil)
    @bike.update(is_available: true, current_station_id: params[:end_station_id])
  end

  def update
  end

  def edit
  end

  def trip_params
    params.require(:trip).permit(:bike_id, :user_id, :start_station_is, :start_time)
  end


end
