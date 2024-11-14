class TripsController < ApplicationController
  def index
    @trips = Trip.all.order(:created_at)
  end

  def _button
    @trip = Trip.new
  end

  def show
      @trip = Trip.find(params[:id])
  end


end
