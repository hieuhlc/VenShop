class Product < ActiveRecord::Base
  attr_accessible :name, :price, :image, :category_id, :category_name, :rate, :description, :count, :user_id
  validates_presence_of :name, :price, :image, :category_name, :description, :count
  VALID_NUM_REGEX = /(0)?[1-9][0-9]*/
  validates(
	:count,
	format: { with: VALID_NUM_REGEX }
	)
  validates(
	:price,
	format: { with: VALID_NUM_REGEX }
	)
  validates(
  	:description, 
  	length: { maximum: 50 }
  	)
  validates(
  	:name, 
  	length: { maximum: 15 }
  	)
end
