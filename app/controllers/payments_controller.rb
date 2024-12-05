class PaymentsController < ApplicationController
  def create 
    @product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      line_items: [{
        # name: @product.name,
        # amount: @product.price,
        # currency: "usd",
        # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
        price: @product.stripe_price_id,
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: root_url,
      cancel_url: products_url,
    })

    redirect_to @session.url, status: 303, allow_other_host: true
  end
end
