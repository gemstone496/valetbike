class StationsController < ApplicationController

  def index
    layout 'main'
    @stations = Station.all.order(identifier: :asc)
  end
  
end
