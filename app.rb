class Map

	attr_reader :length
	attr_reader :width
	attr_reader :taken_coordinate
	
	def initialize (length,width)
		@length = length
		@width = width
		@taken_coordinate = []
		
	end
	

	def in_area? (x,y)
		x >= 0 && x < length && y >= 0 && y  < width
	
	end
	
	
	
	
	def generate_new_coordinate
		coordinate = [].push(Random.new.rand(0..(@length-1))).push(Random.new.rand(0..(@width-1)))
		while @taken_coordinate.include? (coordinate)
				coordinate = [].push(Random.new.rand(0..(@length-1))).push(Random.new.rand(0..(@width-1)))
			end
		add_to_taken_coordinate(coordinate)
		coordinate
	
	end
	
	private
	
	
	def add_to_taken_coordinate(coordinate)
		@taken.push(coordinate)
	
	end
	
	
	
	end
	
	
class Order
	attr_reader :item
	attr_reader :total_price 
	@total_price = 0.0
	
	
	def add_item(item,count)
		@item.push(item)
		@total_price += (item.price * count )
	end
	
	
	def calculate_cost(cost , distance)
	
	end
	

end

class Placeable
	attr_reader :x
	attr_reader :y
	
	def initialize(x,y)
		locate(x,y)
	end
	
	def locate(x,y)
		@x = x
		@y = y
	end
	
	

end

class Item
	attr_reader :name , :price
	
	
	def initialize (name,price)
		@name = name
		@price = price.to_f 
	
	end

end

class Store < Placeable
	attr_reader :name, :item
	
	def initialize (store_name)
		@name = store_name
	end
	
	def add_item (item)
		@item.push(item)
	end
	

end

class User < Placeable
	def initialize(name)
		@name = name
	end

end

class Driver < Placeable
	attr_reader :name 
	attr_reader :rating 
	
	
	def initialize  (name)
		@name = name
		@all_rate = []
		@rating=0.0
	end
	
	def rate(new_rate)
		@all_rate.push(new_rate) 
		rating_counter()
	end
	
	private
	
	def rating_counter
		@rating = @all_rate.sum.to_f/@all_rate.size
	end
	
	
end


class Router
	attr_reader :distance
	
		
		
	
		

end

class OutputController


end


