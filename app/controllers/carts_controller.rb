class CartsController < ApplicationController
	def new
		@cart = Cart.new
	end
	def create
		@cart = Cart.new(params[:cart])
	  	@cart.user_id ||= User.find_by_remember_token(cookies[:remember_token]).id
	  	@cart.product_id = Product.find_by_name(@Product.name).id
	  	if @Product.save
	  		flash[:success] = "Added to cart!"
	  		redirect_to root_url
	  	else
	  		render 'new'
	  	end
  	end
  	def destroy
		
	end
	def create
	  	
	end
end
