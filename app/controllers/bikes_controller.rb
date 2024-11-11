class BikesController < ApplicationController

  def _row
    @bikes = Bike.all.order(identifier: :asc)
  end

  def index
  end

  def show
    @bike = Bike.find(params[:id])
  end

end
