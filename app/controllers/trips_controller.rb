class TripsController < ApplicationController
  def new
    @trip = Trip.new
    @station = Station.find(params[:station_id])
    @user = User.find(params[:user_id])
    @bike = Bike.where(current_station_id: params[:station_id]).first
  end

  def index
    @user = get_user_info_from_session
    @trips = Trip.all.order(end_time: :desc)
    @past_trips = @trips.where.not(end_time: nil)
    @curr_trip = @trips.find_by(end_time: nil)
    if @curr_trip
      @curr_address = Station.find(@curr_trip.start_station_is).address
    end
  end

  def create
    @trip = Trip.new(trip_params)
    @user = User.find(@trip.user_id)
    if !!@user.subscription_id
      # If they have a subscription
      if @trip.save
        @bike = Bike.find(@trip.bike_id)
        @station = Station.find(@trip.start_station_is)
        @user = User.find(@trip.user_id)
        @user.update(current_trip_id: @trip.id)
        @bike.update(is_available: false, current_station_id: nil)
        redirect_to confirm_path(trip_id: @trip.id)
      else
        render :new
      end
    else 
      # No subscription
      flash[:notice] = "Please subscribe to one of the available plans to complete the reservation."
      redirect_to payments_url
    end
  end

  def show
    @trip = Trip.find(params[:trip_id])
  end

  def confirmation
     @trip = Trip.find(params[:trip_id])
  end

  def end_confirmation
    @user = User.find(params[:user_id])
    @trip = Trip.find(@user.current_trip_id)
    
    user_stripe_id = @user.stripe_customer_id
    # Search for the user's available subscription
    subscription = Stripe::Subscription.retrieve(@user.subscription_id)

    # Get the meter event associated with the subscription
    subscription.items.data.each do |item|
      @meter_id = item.plan.meter 
    end

    # Get the product by meter_id
    product = Product.find_by(meter_id: @meter_id)
          
    # Create the meter
    @meter = Stripe::Billing::MeterEvent.create({
        event_name: product.meter_event,
        payload: {
          value: @trip.time_minutes.to_s, # this should be number of minutes
          stripe_customer_id: user_stripe_id
        }
    })
    @bike = Bike.find(@trip.bike_id)
    @user.update(current_trip_id: nil)
    @bike.update(is_available: true, current_station_id: params[:end_station_id])
    @trip.update(end_time: DateTime.now, end_station_id: params[:end_station_id])
  end

  def update
  end

  def edit
  end

  def trip_params
    params.require(:trip).permit(:id, :bike_id, :user_id, :start_station_is, :start_time)
  end

  private
  def trip_time(trip)
    trip
  end

end
