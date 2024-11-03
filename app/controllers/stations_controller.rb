class StationsController < ApplicationController

  def index
    @stations = Station.all.order(identifier: :asc)
  end

  def station
  end
  
end
