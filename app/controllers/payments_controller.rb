class PaymentsController < ApplicationController
  before_action :set_product, :get_user_info_from_session, only: %i[ create ]

  # GET /products 
  def index
    @products = Product.all
  end

  def create 
    if !logged_in? || !@user
      redirect_to log_in_path
    else 
      @session = Stripe::Checkout::Session.create({
        customer: @user.stripe_customer_id,
        line_items: [{
          # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
          price: @product.stripe_price_id
        }],
        mode: 'subscription',
        success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: payments_url,
      })

      redirect_to @session.url, status: 303, allow_other_host: true
    end
  end

  def success 
    if params[:session_id]
      # Display message on successfull subscription
      session_expanded = Stripe::Checkout::Session.retrieve({
        id: params[:session_id],
        expand: ["line_items"]}) 
      session_expanded.line_items.data.each do |item|
        @product = Product.find_by(stripe_product_id: item.price.product)
      end
    else 
      redirect_to root_url
    end
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end
end
