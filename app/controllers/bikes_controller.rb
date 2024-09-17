class BikesController < ApplicationController

  def _row
    @bikes = Bike.all.order(identifier: :asc)
  end

end
