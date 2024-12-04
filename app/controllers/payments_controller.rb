class PaymentsController < ApplicationController

  def subscribe
    user = User.find(params[:user_id])

    customer = Stripe::Customer.create(
      name: user.has_name? || user.email,
      email: user.email,
      desctription: "Customer id: #{params[:user_id]}"
    )

    session = Stripe::Checkout::Session.create(
      customer: customer,
      payment_method_types: ['card'],
      line_items: [{
        price: "price_1QS6gwGS1H69W3qmeSYofOCy"
        quantity: 1
      }],
      mode: "subscription",
      success_url: "stations/show",
      cancel_url: "pricing"
    )
    redirect_to session.url # but actually go here instead...
  end

    
  def pricing
  end
end
