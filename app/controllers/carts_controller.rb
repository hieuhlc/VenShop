class CartsController < ApplicationController
  	before_filter :loged_in_user, only: [:index, :edit, :update, :create, :destroy]
	def new
		@cart = Cart.new
		@Product = Product.find(params[:id])
	end
	def create
		@cart = Cart.new(params[:cart])
		@curr ||= User.find_by_remember_token(cookies[:remember_token])
		@cart.user_id = @curr.id
		@exist = Cart.where(:user_id => @curr.id).where(:product_id => @cart.product_id)
		if !@exist.empty?
			@exist.update_all(:number => @cart.number + @exist.first.number, :pay => false)
			flash[:success] = "Added to cart!"
			return redirect_to @curr
	  	elsif @cart.save
	  		flash[:success] = "Added to cart!"
	  		return redirect_to @curr
	  	else
	  		return render 'new'
	  	end
  	end
  	def pay
  		@curr ||= User.find_by_remember_token(cookies[:remember_token])
  		@cart = Cart.where('user_id = ?', @curr.id).update_all(:pay => true)
  		flash[:success] = "Checked out!!"
  		Usermailer.mail_to(@curr).deliver
		redirect_to @curr
  	end
  	def show
  		@curr ||= User.find_by_remember_token(cookies[:remember_token])
  		redirect_to :controller => "user", :action => "show", :id => @curr.id
  		puts "showwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"
  	end
  	def index
  		render 'show'
  	end
  	def empty
  		Cart.find(:all, :conditions => {:user_id => params[:id]}).each do |item|
  			item.destroy
  		end
  		flash[:success] = "Cart empty!"
  		redirect_to user_path(params[:id])
  	end
  	def destroy
  		@curr ||= User.find_by_remember_token(cookies[:remember_token])
		Cart.find(params[:id]).destroy
		flash[:success] = "Product removed."
		redirect_to @curr
	end
	def edit
		@curr ||= User.find_by_remember_token(cookies[:remember_token])
		@cart = Cart.find(:all, :conditions => "product_id = #{params[:id]} AND user_id = #{@curr.id}").first
	end
	def update
  		@curr ||= User.find_by_remember_token(cookies[:remember_token])
		@cart = Cart.find(params[:id])
		if @cart.update_attributes(params[:cart])
			flash[:success] = "Product info updated!"
			redirect_to @curr
		else
			render 'edit'
		end
	end
	private
	def loged_in_user
	    unless loged_in?
	      store_location
	      redirect_to login_url, notice: "Plz login first!"
	    end
  	end
end
