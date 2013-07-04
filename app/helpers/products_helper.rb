module ProductsHelper
	def product_image(id, size, name)
		if size = "big"
			link = "http://item.shopping.c.yimg.jp/i/g/#{id}"
		else
			link = "http://item.shopping.c.yimg.jp/i/c/#{id}"
		end
    	image_tag(link, alt: name, class: "product_image")
  	end
end