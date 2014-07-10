class StoreController < ApplicationController
  def index
    @products = Product.all
    
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
    
    @message = "You've been here #{session[:counter]} times." if session[:counter] > 5
  end

end
