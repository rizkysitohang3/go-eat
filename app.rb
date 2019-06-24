class Map

	attr_reader :height
	attr_reader :width
	attr_reader :taken_coordinate
	attr_reader :map_image
	
	
	def initialize (height,width)
		@height = height
		@width = width
		@taken_coordinate = []
		@map_image = Array.new(height) {(Array.new(width," . "))}
		
	end
	

	def in_area? (coordinate)
		x,y = *coordinate
		x >= 0 && x < height && y >= 0 && y  < width
	
	end
	
	def generate_new_coordinate
		coordinate = [].push(Random.new.rand(0..(@height-1))).push(Random.new.rand(0..(@width-1)))
		while @taken_coordinate.include? (coordinate)
				coordinate = [].push(Random.new.rand(0..(@height-1))).push(Random.new.rand(0..(@width-1)))
			end
		
		coordinate
	
	end
	
	
	def add_to_map_image(object)
		
		if(object.class == Driver)
			@map_image[object.x][object.y] = " d "
		end
		if(object.class == Store)
			@map_image[object.x][object.y] = " s "
		end
		if(object.class == User)
			@map_image[object.x][object.y] = " u "
		end
	
	end
	
	def remove_from_map_image(object)
		@map_image[object.x][object.y] = " . "
		
	
	end
	
	
	def add_to_taken_coordinate(coordinate)
		@taken_coordinate.push(coordinate)
	
	end
	
	def remove_from_taken_coordinate(coordinate)
		@taken_coordinate.delete_at(@taken_coordinate.index(coordinate))
	
	end
	
	
	end
	
	
class Order

	attr_reader :store,:driver ,:items,:total_price ,:route , :distance
	
	
	
	def initialize(store)
		@store = store
		@total_price = 0.0
		@items = []
		@distance = 0
		@route = []
	end
	
	
	def add_route(route)
		
		
		
		route.each do |step|
			@route.push(step)
			@distance += 1
		
		end
	
	
	end
	
	
	def select_driver(driver)
		@driver = driver
	end
	
	
	def add_item(item,count)
		@items.push(item)
		@total_price += (item.price * count )
	end
	
	
	def set_unit_cost(unit_cost)
		@unit_cost = unit_cost
	
	end
	
	def calculate_fee
		(@unit_cost * @distance)
	end
	
	def calculate_total
		@total_price += calculate_fee
	end
	

end

class Placeable 
	attr_reader :x
	attr_reader :y
	attr_accessor :coordinate
	
	def initialize(coordinate)
		@coordinate = coordinate
		locate(coordinate)
		
	end
	
	def locate(coordinate)
		@x,@y = *coordinate
	end
	
	
	def coordinate
		[].push(@x).push(@y)
	end
	
	
	
	

end

class CoordinateInterface < Placeable

	attr_reader :coordinate , :map
	
	def initialize(coordinate,map)
		@coordinate = coordinate
		@map = map
		@x,@y = *coordinate
		
	end
	
	
	def up		
		x,y= *(@coordinate)
		x-=1
		[].push(x).push(y)
	end
	
	def have_up?
		x,y= *(@coordinate)
		
		x > 0
	end
	
	def left
		x,y= *(@coordinate)
		y-=1
		[].push(x).push(y)
		
	end

	def have_left?
		x,y= *(@coordinate)
		y>0
	end
	
	def right
		x,y= *(@coordinate)
		y+=1
		[].push(x).push(y)
		
	end
	
	def have_right?
		x,y= *(@coordinate)
		y<(@map.height - 1)
	end

	
	def down
		x,y= *(@coordinate)
		x+=1
		[].push(x).push(y)
	end
	
	def have_down?
		x,y= *(@coordinate)
		x<(@map.width - 1)
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
	attr_reader :name, :items
	
	def initialize (store_name)
		@name = store_name
		@items = []
	end
	
	def add_item (item)
		@items.push(item)
	end
	
	def print_information
		puts "Store - #{@name}"
		puts "Location : #{self.coordinate}"
		puts "Item(s) available :"
		@items.each.with_index(1) do |item,number|
			puts "#{number}. #{item.name} : Rp:#{item.price}"
		end
		
	end
	
	def select_item_by_id(id)
		index = id - 1 
		@items[index]
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
	attr_reader :distances , :start_position , :end_position , :paths
	
	
	def initialize (start_position , end_position , map)
		@start_position = CoordinateInterface.new(start_position,map)
		@end_position = CoordinateInterface.new(end_position,map)		
		@paths = []
		@distances = []
		@visited = []
		@last_visited = [].push(start_position)
		@current_position = @start_position
		@map = map
		
	end
	
	
	
	def find_path
		path = []
		steps = []
		distance = 0
		found_path_flag = 0
		
		
		while has_possible_step?
				
				if found_path_flag == 1 
					break
				end
				
				
				steps.clear
				steps = possible_step
									
				
				while !(steps.empty?)
				next_step = best_step(steps)
				
				
				if next_step == @end_position.coordinate
					
					
					found_path_flag = 1		
					
					path.push(next_step)
					distance += 1
					@paths=path.drop(0)
					@last_visited.clear
					@last_visited = [].push(start_position.coordinate)
					@distances = distance
					@current_position = @start_position
					
					distance = 0
					path.clear
					
					break
					
				
				elsif !(@visited.include?(next_step))
					@visited.push(next_step)
					distance += 1
					path.push(next_step)
					@last_visited.push(next_step)
					@current_position.coordinate = next_step
					break
					
					
				
				elsif @last_visited.last == next_step 	
					
					@last_visited.pop
					path.pop
					distance--
					@current_position.coordinate == next_step
					break
				
				
				
				
				end
				
				
				end
				
		
		
		
		
		end
		
		
	end
	
	
	
	
	
	
	
	
	def best_step(steps)
		
		all_deltas = []
		
		
		steps.each do |step|
			
			
			step_x,step_y = *step
			delta_x = (@end_position.x >= step_x ?  @end_position.x - step_x : step_x - @end_position.x ) #selisih
			delta_y = (@end_position.y >= step_y ?  @end_position.y - step_y : step_y - @end_position.y ) #selisih
			all_deltas.push(delta_x + delta_y)
			
		end
		
		
		steps[all_deltas.index(all_deltas.min)]
		
		
	
	end
	
	def has_possible_step?
		(@current_position.have_up? and ( !(@map.taken_coordinate.include?(@current_position.up)) or   (@current_position.up == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.up))   or  @last_visited.last == @current_position.up  ) )or 
		(@current_position.have_down? and ( !(@map.taken_coordinate.include?(@current_position.down)) or   (@current_position.down == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.down))   or  @last_visited.last == @current_position.down  ) ) or 
		(@current_position.have_left? and ( !(@map.taken_coordinate.include?(@current_position.left)) or   (@current_position.left == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.left))   or  @last_visited.last == @current_position.left  ) ) or 
		(@current_position.have_right? and ( !(@map.taken_coordinate.include?(@current_position.right)) or   (@current_position.right == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.right))   or  @last_visited.last == @current_position.right  ) )
		
	end	
	
	
	def possible_step
		steps = []
		
		if (@current_position.have_up? and ( !(@map.taken_coordinate.include?(@current_position.up)) or   (@current_position.up == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.up))   or  @last_visited.last == @current_position.up  ) )
			steps.push(@current_position.up)
		end
		
		if (@current_position.have_down? and ( !(@map.taken_coordinate.include?(@current_position.down)) or   (@current_position.down == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.down))   or  @last_visited.last == @current_position.down  ) )
			steps.push(@current_position.down)
		end
		
		if (@current_position.have_left? and ( !(@map.taken_coordinate.include?(@current_position.left)) or   (@current_position.left == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.left))   or  @last_visited.last == @current_position.left  ) )
			steps.push(@current_position.left)
		end
		
		if (@current_position.have_right? and ( !(@map.taken_coordinate.include?(@current_position.right)) or   (@current_position.right == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.right))   or  @last_visited.last == @current_position.right  ) )
			steps.push(@current_position.right)
		end
		
		steps
		
	
	end
	
		
	
	def has_path?
		@paths.size > 0
	
	end
		
		

end

module OutputController
	
	
	def show_information(objects)
		
	end
	
	def show_driver_information(drivers)
		drivers.each do |driver|
		puts "Driver - #{driver.name} . Location : #{driver.coordinate}  Rating : #{driver.rating}"
	
		end
	end
	
	def show_store_information(stores)
		stores.each do |store|
		puts "Store - #{store.name} . Location : #{store.coordinate}"
		end
	end
	
	def show_item_store_information(store)
		
		
		puts "Item(s) available :"
		store.item.each.with_index(1) do |item,number|
			puts "#{number}. #{item.name} : Rp:#{item.price}"
		end
	end
	
	
	def show_map_information(map)
		map.map_image.each do |height|
			height.each do |element|
				print element
			end
			puts ""
		end
	
	
	end
	
	def show_order_information(order)
		
		
	end
	

end


module NameGenerator
	Name = ["glien","rizky","nufi","prince","koko","paddy","dody","rommel","taro","boy","ivan","bimo","jovan","david","martin","juanda","daniel","yudhi"]
	
	def NameGenerator.generate 
		new = Name[Random.new.rand(0..(Name.size - 1))]
	end
	
end






# Main Class Method

include OutputController

def is_name_used?(name)
	
	@used_name.include?(name)
	
end

def unuse_name(name)
	@used_name.delete_at(@used_name.index(name))
		
end

def use_name(name)
	@used_name.push(name)
end

def generate_unused_name
	name = NameGenerator::generate
	while @used_name.include?(name)
		name = NameGenerator::generate
	end
	use_name(name)
	name
	
end


def create_default_store
	store_names = ["Toko ku", "Toko mu" , "Toko nya"]
	
	store_names.each do |store_name|
		store = Store.new(store_name)
		store.locate(@map.generate_new_coordinate)
		@map.add_to_taken_coordinate(store.coordinate)
		@items.each do |item|
			store.add_item(item)
		
		end
		@map.add_to_map_image(store)
		@stores.push(store)
		
	end
	
	

end

def create_item
	

end

def create_default_driver(number_of_driver)
	
	number_of_driver.times do  
		new_driver = generate_new_driver(generate_unused_name)
		@map.add_to_map_image(new_driver)
		@drivers.push(new_driver)
	end
	
	
	
end




def generate_new_driver(driver_name)
	
	tried_coordinate = []
	flag = 0
	while flag != @stores.size
	flag=0
	coordinate = @map.generate_new_coordinate
		while tried_coordinate.include?(coordinate)
		coordinate = @map.generate_new_coordinate
		end
	driver = Driver.new(driver_name)
	driver.locate(coordinate)
	
	@stores.each do |store|
		router = Router.new(driver.coordinate,store.coordinate,@map)
		router.find_path
		if router.has_path?
		flag += 1	
		end
		
	
	
		
	end
	
	
	
	end
	tried_coordinate.push(coordinate)
	@map.add_to_taken_coordinate(driver.coordinate)
	driver
	
end

def set_default_item
	default_items = {"Milkita Candy" => 5000,"Martabak" => 16000,"Susu" => 7000, "Kopi"=>8500}
	default_items.each do |item_name,item_price|
		item = Item.new(item_name,item_price)
		@items.push (item)
		
	end
	
	
	
end




def set_user(name = "kylex",location=@map.generate_new_coordinate)
	@user = User.new(name)
	@user.locate(location)
	@map.add_to_map_image(@user)
	

end

def create_map(height=20,width=20)
	@map = Map.new(height,width)
end

def add_to_orders_history(order)
	@orders_history.push(order)

end


def process_order(order)
	router = Router.new(order.driver.coordinate,order.store.coordinate,@map)
	router.find_path
	route = router.paths
	
	order.add_route(route)
	puts "-\tdriver (#{order.driver.name}) is on the way to store, start at #{order.driver.coordinate}"
	route.each.with_index do |step,index|
		if	index == (route.size - 1)
			puts "-\tgo to #{step}, driver arrived at store (#{order.store.name})"
		else
			puts "-\tgo to #{step}"
		end
		
	end 
	
	puts "-\tdriver has bought the item(s), start at #{order.store.coordinate}"
	router = Router.new(order.store.coordinate,@user.coordinate,@map)
	router.find_path
	route = router.paths
	order.add_route(route)
	
	route.each.with_index do |step,index|
		if	index == (route.size - 1)
			puts "-\tgo to #{step}, driver arrived at your place!"
		else
			puts "-\tgo to #{step}"
		end
		
	end
	
	order.driver.rate(5)
	
	
	
	
end
# Main Class 


@used_name = []
@map
@drivers = []
@user
@items = []
@stores = []
@orders_history = []  

#default case 





















