require "stripe"

# In config/application.rb, normally we require rails/all
# Instead, we'll only require what we need:
require "action_controller/railtie"

Stripe.api_key = ENV["STRIPE_API_KEY"]

class StripeCheckout < Rails::Application
  config.eager_load = true # necessary to silence warning
  config.api_only = true # removes middleware we dont need
  config.logger = Logger.new($stdout)
  Rails.logger  = config.logger
  config.secret_key_base = ENV["SECRET_KEY_BASE"] # Rails won't boot w/o a secret token for session, cookies, etc.
  routes.append { post "/create-checkout-session" => "checkouts#create" }
end

class CheckoutsController < ActionController::Base
  def create
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: 'T-shirt',
          },
          unit_amount: 2000,
        },
        quantity: 1,
      }],
      mode: 'payment',
      # For now leave these URLs as placeholder values.
      #
      # Later on in the guide, you'll create a real success page, but no need to
      # do it yet.
      success_url: 'https://example.com/success',
      cancel_url: 'https://example.com/cancel',
    })
  
    render json: { id: session.id }
  end
end

# Initialize the app (originally in config/environment.rb)
StripeCheckout.initialize!

# Run it (originally in config.ru)
run StripeCheckout