class TripsController < ApplicationController

  def new
    @trip = Trip.new
    @bike = Bike.find(params[:bike_id])
    @station = Station.find(params[:station_id])
    @user = User.find(params[:user_id])
  end


  def create
    @bike = Bike.find(params[:bike_id])
    @station = Station.find(params[:station_id])
    @user = User.find(params[:user_id])
    @trip = Trip.new(params.require(:trip).permit(:start_time,
                                                  :start_station_id,
                                                  :bike_id,
                                                  :user_id))
    if @trip.save
      redirect_to trip_confirmation_path
    else
      render :new
    end
  end
  def show
    @trip = Trip.find(params[:id])
  end

  def update
  end

  def edit
  end


end
