class StationsController < ApplicationController

  def index
    @stations = Station.all.order(identifier: :asc)
  end
  
  def initialize
    self.index
  end
end
