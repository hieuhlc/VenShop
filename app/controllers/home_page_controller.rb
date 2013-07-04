class HomePageController < ApplicationController
  def home
  	@Product = Product.find(:all,:order => "rate DESC", :limit => 6)
  	@Count = Product.find(:all, :order => "updated_at DESC", :limit => 6)
  end

  def login
  end

  def register
  end
end
