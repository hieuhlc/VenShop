class Product < ActiveRecord::Base
  attr_accessible :name, :price, :image, :category_id, :category_name, :rate, :description, :count, :user_id
  # validates_presence_of :name, :price, :image, :category_name, :description, :count
end
