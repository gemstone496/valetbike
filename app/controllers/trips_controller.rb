class TripsController < ApplicationController

  def new
    @trip = Trip.new
      @bike = Bike.find(params[:bike_id])
      @station = Station.find(params[:station_id])
      @user = User.find(params[:user_id])
  end

  def create
  end
  def show
    @trip = Trip.find(params[:id])
  end

  def update
  end

  def edit
  end

end
