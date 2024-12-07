class TripsController < ApplicationController
  def new
    @trip = Trip.new
    @bike = Bike.find(params[:bike_id])
    @station = Station.find(params[:station_id])
    @user = User.find(params[:user_id])
  end

  def create
    @trip = Trip.new(trip_params)
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
  end
  def show
    @trip = Trip.find(params[:trip_id])
  end

  def confirmation
     @trip = Trip.find(params[:trip_id])
  end

  def end_confirmation
    @user = User.find(@trip.user_id)
    if !!@user.subscription_id
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
          value: '50', # I'm hardcoding a constant here. But we're supposed to input # of minutes
          stripe_customer_id: user_stripe_id
        }
      })
      @trip = Trip.find(params[:trip_id])
      @bike = Bike.find(@trip.bike_id)
      @user.update(current_trip_id: nil)
      @bike.update(is_available: true, current_station_id: params[:end_station_id])
    else 
      # No subscription
      # Make the trip status *Payment pending*
      redirect_to payments_url
    end
  end

  def update
  end

  def edit
  end

  def trip_params
    params.require(:trip).permit(:bike_id, :user_id, :start_station_is, :start_time)
  end

end
