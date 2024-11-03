class StationsController < ApplicationController
  layout 'main'

  def index
    @stations = Station.all.order(identifier: :asc)
  end
  
end
