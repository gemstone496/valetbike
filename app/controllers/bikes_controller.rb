class BikesController < ApplicationController

  def _row
    @bikes = Bike.all.order(identifier: :asc)
    # @logged_in = logged_in?
  end

  def index
  end

  def show
    @bike = Bike.find(params[:id])
  end

end
