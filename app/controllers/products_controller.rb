require 'net/http'
require 'json'
require 'open-uri'
require 'rubygems'
require 'solr'
require 'will_paginate/array'
#encoding: utf8
class ProductsController < ApplicationController
	def index
		#@Product = Product.paginate(:page => params[:page], :per_page => 20, :conditions => ['name LIKE ?', params[:search]])
		solr_search(params[:search],params[:page].to_i)
	end
	def show
		@Product = Product.find(params[:id])
		@curr ||= User.find_by_remember_token(cookies[:remember_token])
	end
	def new
		@Product = Product.new
	end
	def edit
		@Product = Product.find(params[:id])
	end
	def update
		@Product = Product.find(params[:id])
		if @Product.update_attributes(params[:Product])
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
	  	@Product = Product.new(params[:product])
	  	@Product.user_id ||= User.find_by_remember_token(cookies[:remember_token]).id
	  	@Product.category_id = Category.find_by_name(@Product.category_name).cat_id
	  	if @Product.save
	  		flash[:success] = "Product added!"
	  		redirect_to @Product
	  	else
	  		render 'new'
	  	end
	end
	private
	def solr_search(query, page)
		if page == 0
     	 page = 1
  		end
    	perpage = 10
    	start = perpage * (page-1)

		solr = Solr::Connection.new('http://localhost:8080/apache-solr-3.6.2/core0', :autocommit => :on)
		query_obj = Solr::Request::Select.new(nil, {'q' => "name:\"#{query}\" OR description:\"#{query}\"",'rows' => perpage, 'start' => start})
		result = solr.send(query_obj).data["response"]
		@pages = (1..result["numFound"].to_i).to_a.paginate(page: page, per_page: perpage, window: 2, outer_window: 2, left: 2, right: 2)
		@Product = result["docs"]
	end
end