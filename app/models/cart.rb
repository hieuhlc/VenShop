class Cart < ActiveRecord::Base
  attr_accessible :number, :product_id, :user_id
end
