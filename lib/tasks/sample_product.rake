require 'net/http'
require 'json'
require 'open-uri'
#encoding: utf8
def get_cat_id
	appid = "dj0zaiZpPXpIMzBsMUQyTk55dSZkPVlXazlZWGxzYjNoWU0yVW1jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9MzI"
	@res = open("http://shopping.yahooapis.jp/ShoppingWebService/V1/json/categorySearch?appid="+appid+"-&category_id=1").read
	return @res
end
def get(cat_id,hit,offset)
	appid = "dj0zaiZpPXpIMzBsMUQyTk55dSZkPVlXazlZWGxzYjNoWU0yVW1jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9MzI"
	@result = open("http://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch?appid="+appid+"-&category_id="+cat_id+"&hits="+hit.to_s+"&offset="+offset.to_s+"&sort=-sold").read
	return @result
end
namespace :db do
  desc "Fill sample products"
  task getdata: :environment do
  	@cat_id_set = JSON.parse(get_cat_id)
    cate_id = @cat_id_set['ResultSet']['0']['Result']['Categories']['Children']
    (0..19).each do |sub_id|
    	category_name = cate_id[sub_id.to_s]['Title']['Medium']
    	(0..19).each do |offset|
			@parsed_data = JSON.parse(get(cate_id[sub_id.to_s]['Id'],50,offset*50))
			puts "---------------------------------------------------"
			@parsed_data['ResultSet']['0']['Result'].each do |index, prefix|
				if (index.to_i.to_s == index.to_s)
					name = prefix['Name']
					price = prefix['Price']['_value']
					image = prefix['Image']['Id']
					rate = prefix['Review']['Rate'].to_i
					count = prefix['Review']['Count'].to_i
					desc = prefix['Description']
					Product.create!(name: name, 
						price: price, 
						image: image, 
						category_id: cate_id[sub_id.to_s]['Id'].to_i, 
						category_name: category_name, 
						rate: rate, 
						count: count,
						description: desc
						)
				end
			end
		end
		Category.create!(name: category_name, cat_id: cate_id[sub_id.to_s]['Id'].to_i)
	end
  end
end
# namespace :db do
# 	desc "Fill sample Category Id"
# 	task cate_id: :environment do
# 		@cat_id_set = JSON.parse(get_cat_id)
# 		cate_id = @cat_id_set['ResultSet']['0']['Result']['Categories']['Children']
# 		(0..19).each do |sub_id|
# 			name = cate_id[sub_id.to_s]['Name']
# 			id = cate_id[sub_id.to_s]['Id']
# 			Category.create!(name: name, cat_id: id)
# 		end
# 	end
# end