class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :date_loaded, :counter_loaded
  def date_loaded
    t = Time.now
    time = "#{'%02d' % t.hour}:#{'%02d' % t.min} - #{'%02d' % t.day}/#{'%02d' % t.month}/#{t.year}"
  end
  
  private
    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
    
    def counter_loaded
      if session[:counter] > 5
        return session[:counter]
      else
        return nil
      end
    end
end
