class CategoriesController < ApplicationController
	def new
		@Category = Category.new
	end
	def create
		@Category = Category.new(params[:category])
	  @Category.save
  end
	def index
		@Category = Category.all
	end
	def show
		@Category = Category.find(params[:id])
		@Product = Product.paginate(:page       => params[:page],
                         :per_page   => 20,
                         :conditions => { :category_id => @Category.cat_id })
	end
end
