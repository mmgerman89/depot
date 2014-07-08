class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :date_loaded
  def date_loaded
    Time.now
  end
  
  private
    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
end
