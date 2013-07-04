require 'net/http'
require 'json'
require 'open-uri'
#encoding: utf8
class ProductsController < ApplicationController
	def index
		@Product = Product.paginate(page: params[:page], per_page: 20)
	end
	def show
		@Product = Product.find(params[:id])
	end
	def new
		@Product = Product.new
	end
	def edit
		@Product = Product.find(params[:id])
	end
	def update
		@Product = Product.find(params[:id])
		if @Product.update_attributes(params[:id])
			flash[:success] = "Product info updated!"
			redirect_to @Product
		else
			render 'edit'
		end
	end
	def destroy
		@curr ||= User.find_by_remember_token(cookies[:remember_token])
		Product.find(params[:id]).destroy
		flash[:success] = "Product removed."
		redirect_to @curr
	end
	def create
	  	@Product = Product.new(params[:Product])
	  	@Product.user_id ||= User.find_by_remember_token(cookies[:remember_token]).id
	  	@Product.category_id = Category.find(:all, :conditions => { :name => @Product.category_name })
	  	if @Product.save
	  		flash[:success] = "Product added!"
	  		redirect_to @Product
	  	else
	  		render 'new'
	  	end
	end
end