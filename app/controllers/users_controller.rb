class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end
  def new
  	@user = User.new
  	flash[:success] = "Registration Succeeded! Welcome to VenShop :)"
  		
  end
  def create
  	@user = User.new(params[:user])
  	if @user.save
  		flash[:success] = "Registration Succeeded! Welcome to VenShop :)"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

end

