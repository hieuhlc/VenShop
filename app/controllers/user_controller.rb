class UserController < ApplicationController
  before_filter :loged_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  def show
  	@user = User.find(params[:id])
    @Product = Product.paginate(:page => params[:page], :per_page => 20, :conditions => { :user_id => @user.id })
    @cart = Cart.paginate(:page => params[:page], :per_page => 20, :conditions => { :user_id => @user.id })
  end
  def index
    @user = User.paginate(page: params[:page], per_page: 10)
  end
  def new
  	@user = User.new
  end
  def create
  	@user = User.new(params[:user])
  	if @user.save
  		log_in @user
  		flash[:success] = "Registration Succeeded! Welcome to VenShop :)"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end
  def edit
  	@user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated!"
      log_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted!"
    redirect_to user_index_url
  end
  private
  def loged_in_user
    unless loged_in?
      store_location
      redirect_to login_url, notice: "Plz login first!"
    end
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  def admin_user
    unless current_user.admin?
      redirect_to(root_path)
    end
  end
end