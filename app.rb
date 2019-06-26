class Map

	attr_reader :height ,:width,:taken_coordinate,:blocked_coordinate,:map_image
	
	
	
	
	def initialize (size)
		@height = size
		@width = size
		@taken_coordinate = []
		@blocked_coordinate = []
		@map_image = Array.new(height) {(Array.new(width," . "))}
		
	end
	

	def in_area? (coordinate)
		x,y = *coordinate
		x >= 0 && x < height && y >= 0 && y  < width
	
	end
	
	def generate_new_coordinate
		coordinate = [].push(Random.new.rand(0..(@height-1))).push(Random.new.rand(0..(@width-1)))
		while @taken_coordinate.include?(coordinate)
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
	
	def number_of_untaken_coordinate
		(@height * @width ) - @taken_coordinate.size
	end
	
	def add_to_blocked_coordinate(coordinate)
		@blocked_coordinate.push(coordinate)
	end
	
	end
	
	
class Order

	attr_reader :store,:driver ,:items,:amounts,:total_price ,:route , :distance ,:unit_cost, :fee
	
	
	
	def initialize(store)
		@store = store
		@total_price = 0.0
		@items = []
		@distance = 0
		@route = []
		@amounts = []
	end
	
	
	def add_route(route)
		
		
		
		route.each do |step|
			@route.push(step)
			@distance += 1
		
		end
	
	
	end
	
	
	def select_driver(driver)
		@driver = driver
		@route.push(driver.coordinate)
	end
	
	
	def add_item(item,amount)
		if	@items.include?(item)
			@amounts[@items.index(item)] += amount
		
		else
		@items.push(item)
		@amounts.push(amount)
		end
		
		@total_price += (item.price * amount )
	end
	
	
	def set_unit_cost(unit_cost)
		@unit_cost = unit_cost
	
	end
	
	def calculate_fee
		@fee = (@unit_cost * @distance)
	end
	
	def calculate_total
		@total_price += calculate_fee
	end
	

end

class Placeable 
	attr_reader :x,:y
	attr_writer :coordinate
	
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
		@last_visited = []
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
					@last_visited.push(start_position.coordinate)
					@distances = distance
					@current_position = @start_position
					
					distance = 0
					path.clear
					
					break
					
				
				elsif !(@visited.include?(next_step))
					@visited.push(next_step)
					distance += 1
					path.push(next_step)
					@last_visited.push(@current_position.coordinate)
					@current_position.coordinate = next_step
					break
					
					
				
				elsif @last_visited.last == next_step 	#untuk mundur
					
					@last_visited.pop
					path.pop
					distance -= 1 
					@current_position.coordinate == next_step
					break
				
				
				
				
				end
				
				
				end
				
		
		
		
		
		end
		
		
	end
	
	
		
	
	def has_path?
		@paths.size > 0
	
	end
		
	
	private
	
	
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
		(@current_position.have_up? and ( !(@map.blocked_coordinate.include?(@current_position.up)) or   (@current_position.up == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.up))   or  @last_visited.last == @current_position.up  ) )or 
		(@current_position.have_down? and ( !(@map.blocked_coordinate.include?(@current_position.down)) or   (@current_position.down == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.down))   or  @last_visited.last == @current_position.down  ) ) or 
		(@current_position.have_left? and ( !(@map.blocked_coordinate.include?(@current_position.left)) or   (@current_position.left == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.left))   or  @last_visited.last == @current_position.left  ) ) or 
		(@current_position.have_right? and ( !(@map.blocked_coordinate.include?(@current_position.right)) or   (@current_position.right == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.right))   or  @last_visited.last == @current_position.right  ) )
		
	end	
	
	
	def possible_step
		steps = []
		
		if (@current_position.have_up? and ( !(@map.blocked_coordinate.include?(@current_position.up)) or   (@current_position.up == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.up))   or  @last_visited.last == @current_position.up  ) )
			steps.push(@current_position.up)
		end
		
		if (@current_position.have_down? and ( !(@map.blocked_coordinate.include?(@current_position.down)) or   (@current_position.down == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.down))   or  @last_visited.last == @current_position.down  ) )
			steps.push(@current_position.down)
		end
		
		if (@current_position.have_left? and ( !(@map.blocked_coordinate.include?(@current_position.left)) or   (@current_position.left == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.left))   or  @last_visited.last == @current_position.left  ) )
			steps.push(@current_position.left)
		end
		
		if (@current_position.have_right? and ( !(@map.blocked_coordinate.include?(@current_position.right)) or   (@current_position.right == @end_position.coordinate)     ) and (!(@visited.include?(@current_position.right))   or  @last_visited.last == @current_position.right  ) )
			steps.push(@current_position.right)
		end
		
		steps
		
	
	end
	
	
		

end

module OutputController
	
	
	def show_main_menu
		puts "Menu :"
		puts "1. Show Map"
		puts "2. Order Food"
		puts "3. View History"
		puts "4. Exit"
		
		
	end
	
	
	def show_driver_information(drivers)
		drivers.each.with_index(1) do |driver,id|
		puts "#{id}.Driver - #{driver.name} . Location : #{driver.coordinate}  Rating : #{driver.rating}"
	
		end
	end
	
	def show_store_information(stores)
		stores.each.with_index(1) do |store,id|
		puts "#{id}.#{store.name} . Location : #{store.coordinate}"
		end
	end
	
	def show_item_store_information(store)
		
		
		
		store.items.each.with_index(1) do |item,number|
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
		
		puts "Information Coordinate :"
		puts "[0,0]---[0,#{map.width - 1}]"
		puts "  |       |  "
		puts "[#{map.height - 1},0]---[#{map.height - 1},#{map.width - 1}]"
	
	
	end
	
	def show_order_information(order)
		puts "----- Order Information -----"
		puts "Store : #{order.store.name}"
		puts "Location : #{order.store.coordinate}"
		puts "Item(s) bought :"
		order.items.each.with_index do |item,index|
			puts " - #{item.name} (#{order.amounts[index]}) : Rp.#{item.price * order.amounts[index]}"
		end
		puts "Driver : #{order.driver.name} from #{order.driver.coordinate}"
		puts "Route taken : "
		order.route.each.with_index do |step,index|
			print "#{step} "
			if index != order.route.size - 1
				print "-> "
			end
		end
		puts ""
		puts "Distance : #{order.distance} (unit cost : #{order.unit_cost}) "
		puts "Driver fee : #{order.fee}"
		puts "Total price : Rp.#{order.total_price}"
		puts "------------ End ------------"
		puts ""
		
		
	end
	
	def	print_to_file(filename,order)
		#  automatically create new file if not exist and using this will automatically close the file after finish writing 
		default_stdout = $stdout
		File.open(filename,"a") do |file_output|
		
			$stdout = file_output
			show_order_information(order)
			
		end
		$stdout = default_stdout
	
	end
	
	def clear_screen
		system "clear"
	end	

	def delay_output(second)
		system "sleep #{second}"
	end
	
	def show_order_history(filename)
		
		if File::exist?(filename)
			file = File.open(filename,"r")
			
			if file.size > 0
				order_history = file.read
				puts order_history
			else
				puts "No order record found."
			end
			
			
			
		else
			puts "No order record found."
		end
		
	end

end


module NameGenerator
	Name = ["Glien","Rizky","Nufi","Prince","Koko","Paddy","Dody","Rommel","Taro","Boy","Ivan","Bimo","Jovan","David","Martin","Juanda","Daniel","Yudhi"]
	
	def NameGenerator.generate 
		new = Name[Random.new.rand(0..(Name.size - 1))]
	end
	
end


module InputController

	def get_user_input(max_range)
		print '> '
		min_range=1
		
		user_input = $stdin.gets.chomp.to_i
		
		while !user_input.between?(min_range,max_range)
			warn "Invalid input. re-enter"
			print '> '
			user_input = $stdin.gets.chomp.to_i
			
		end
		
		clear_screen
		user_input
	end
	
	def press_enter_to_continue
		print "Press Enter to continue.."
		$stdin.gets
		clear_screen
	end

	
	
end



module NameController


		def is_name_used?(name)
			
			@used_name.include?(name)
			
		end

		def unuse_name(name)
			if @used_name.include?(name)
				@used_name.delete_at(@used_name.index(name))
			
			end
			
				
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
end

module MapController
	def create_map(size=20)
		@map = Map.new(size)
	end

end

module DriverController


	def delete_driver(driver)
		@map.remove_from_map_image(driver)
		@map.remove_from_taken_coordinate(driver.coordinate)
		unuse_name(driver.name)
		@drivers.delete_at(@drivers.index(driver))
	end

	def driver_evaluator(driver)
		if driver.rating < 3
			puts "The app is looking for drivers..."
			delay_output(1)
			delete_driver(driver)
			create_random_driver(1)
			
			
		end

	end
	
	
	def create_random_driver(number_of_driver)
	
		number_of_driver.times do  
			new_driver = generate_new_driver(generate_unused_name)
			if new_driver == "failed"
				puts "Failed to generate driver , not all driver can reach all stores"
				error_exit_program
			end
			@map.add_to_map_image(new_driver)
			@drivers.push(new_driver)
			
		end
		
	end
	
	def create_driver(driver_name ,location)
		if(@map.taken_coordinate.include?(location))
			puts "Failed to locate driver #{driver_name} ! location was taken by other"
			error_exit_program
			
		elsif !@map.in_area?(location)
			puts "Failed to locate driver #{driver_name} ! location out of map"
			error_exit_program
		
		end
		driver = Driver.new(driver_name)
		driver.locate(location)
		flag = 0
		@stores.each do |store|
			router = Router.new(driver.coordinate,store.coordinate,@map)
			router.find_path
			if router.has_path?
			flag += 1	
			end	
		end
		if flag != @stores.size
			puts "Failed to locate driver #{driver_name} ! driver can't reach all stores"
			error_exit_program
		end
		@map.add_to_taken_coordinate(driver.coordinate)
		@map.add_to_map_image(driver)
		driver
		
	
	
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
		tried_coordinate.push(coordinate)
		return "failed" if @map.number_of_untaken_coordinate == tried_coordinate.size
		
		end
		
		
		@map.add_to_taken_coordinate(driver.coordinate)
		driver
		
	end


end

module UserController

	def set_user(location=@map.generate_new_coordinate)
		name = "kylex"
		if @map.taken_coordinate.include?(location)
			puts "Failed to locate user ! location taken by others "
			error_exit_program
		end
		@user = User.new(name)
		@user.locate(location)
		@map.add_to_taken_coordinate(location)
		@map.add_to_map_image(@user)
		

	end


end

module StoreController

	def create_default_store
		store_names = ["Toko ku", "Toko mu" , "Toko nya"]
		
		store_names.each do |store_name|
			create_store(store_name,@default_items)
			
		end
		

	end
	
	def create_store(store_name, items ,location=@map.generate_new_coordinate)
			
			
			if(@map.taken_coordinate.include?(location))
				puts "Failed to locate store #{store_name} ! location taken by others "
				error_exit_program
				
			elsif !@map.in_area?(location)
				puts "Failed to locate store #{store_name} ! location out of map"
				error_exit_program
				
			end
			store = Store.new(store_name)
			store.locate(location)
			@map.add_to_taken_coordinate(store.coordinate)
			@map.add_to_blocked_coordinate(store.coordinate)
			items.each do |item|
				store.add_item(item)
			
			end
			@map.add_to_map_image(store)
			@stores.push(store)
			
		
		
	end


end

module ItemController


	def set_default_item
		default_items = {"Milkita Candy" => 5000,"Martabak" => 16000,"Susu" => 7000, "Kopi"=>8500}
		default_items.each do |item_name,item_price|
			item = create_item(item_name,item_price)
			@default_items.push (item)
			
		end
		
		
		
	end
	
		
	def create_item(item_name,item_price)
		item = Item.new(item_name,item_price)
		
		
	end


end

module OrderController


	def process_order
		router = Router.new(@order.driver.coordinate,@order.store.coordinate,@map)
		router.find_path
		route = router.paths
		
		@order.add_route(route)
		puts "-\tdriver (#{@order.driver.name}) is on the way to store, start at #{@order.driver.coordinate}"
		route.each.with_index do |step,index|
			
			if	index == (route.size - 1)
				puts "-\tgo to #{step}, driver arrived at store (#{@order.store.name})"
			else
				puts "-\tgo to #{step}"
			end
			delay_output(0.4)
		end 
		delay_output(1)
		puts "-\tdriver has bought the item(s), start at #{@order.store.coordinate}"
		router = Router.new(@order.store.coordinate,@user.coordinate,@map)
		router.find_path
		route = router.paths
		@order.add_route(route)
		
		route.each.with_index do |step,index|
			if	index == (route.size - 1)
				puts "-\tgo to #{step}, driver arrived at your place!"
			else
				puts "-\tgo to #{step}"
			end
			
			delay_output(0.4)
		end
		
		@order.calculate_total
		
		puts "Input driver rating (1-5):"
		rating = get_user_input(5)
		
		@order.driver.rate(rating)
		
		
	end
	
	
	
	
	def set_order_driver_handler
		puts "Select available driver :"
		show_driver_information(@drivers)
		puts "#{@drivers.size + 1 }.Cancel"
		driver_id = get_user_input(@drivers.size + 1)
		return "cancel" if driver_id == @drivers.size + 1
		@order.select_driver(@drivers[driver_id-1])
		

	end



	def create_order_handler

		puts "Select available store :"
		show_store_information(@stores)
		puts "#{@stores.size+1}.Cancel"
		selected_store_id = get_user_input(@stores.size + 1)
		return "cancel" if selected_store_id == @stores.size + 1
		store = @stores[selected_store_id - 1]
		@order = Order.new(store)
		
		other_item_choice = 1
		
		while other_item_choice == 1
		
		puts "Select available item :"
		show_item_store_information(store)
		puts "#{store.items.size + 1}. Cancel"
		selected_item_id = get_user_input(store.items.size + 1)
		return "cancel" if selected_item_id == store.items.size + 1
		
		puts "Input amount (max:50):"
		item_amount =  get_user_input(50)
		@order.add_item(@order.store.select_item_by_id(selected_item_id),item_amount)
		puts "Another item ?"
		puts "1. Yes"
		puts "2. No"
		puts "3. Cancel"
		
		other_item_choice = get_user_input(3)
		return "cancel" if other_item_choice == 3
		
		end
		
		
		
		

	end

end

module MainHandler
	
	def start_program_handler	

			if ARGV.empty?
				
				default_case
				
			elsif ARGV.size == 3
				n,x,y = *ARGV
				with_arguments_case(n,x,y)
				
					

			elsif ARGV.size == 1
				filename = ARGV[0]
				with_filename_case(filename)


			else
			
				print_usage
				error_exit_program

			end

	end
	
	def main_menu_handler
		while true
		show_main_menu
		@user_input = get_user_input(4)
		
		if @user_input == 1
			
			show_map_information(@map)
			press_enter_to_continue
		
		elsif @user_input == 2
			unless create_order_handler == "cancel"
			@order.set_unit_cost(500) # assume unit cost set default by application
				unless set_order_driver_handler == "cancel"
				process_order
				show_order_information(@order)
				print_to_file(@order_history_filename,@order)
				driver_evaluator(@order.driver)
				press_enter_to_continue
				end
			end
		elsif @user_input == 3
			show_order_history(@order_history_filename)
			press_enter_to_continue
		else
			normal_exit_program
		
		
		end
		end

	
	end
	
	
	def print_usage
		puts "Usage: app.rb "
		puts "Usage: app.rb [n] [x] [y]"
		puts "Usage: app.rb [filename]"
		puts
		puts "n \t: this is for map size n * n "
		puts "x,y \t: this is for user location coordinate (x,y) "
		puts "filename \t: this is for import all setting from file "
		
		
	end
	
	
	
	def normal_exit_program
		puts "Exiting..."
		exit(0)

	end

	def error_exit_program
		puts "Exiting..."
		exit(1)
	end

	def map_size_checker(map_size,number_of_driver,number_of_store)
		if map_size **2 <= number_of_driver + number_of_store + 1
			puts "the map size is too small."
			error_exit_program
			
		elsif map_size > 50
		
			puts "the map size is too big. max is 50"
			error_exit_program
			
		end

	end
	
	

	def default_case
		#without argument
		#create  map , default = 20x20
		create_map
		#set default item for store
		set_default_item
		#create store
		create_default_store
		#create drivers
		create_random_driver(@default_number_of_driver)
		#set user 
		set_user

	end
	
	def with_arguments_case(n,x,y)
	
		if n.to_i.to_s == n and n.to_i > 1
						
						if x.to_i.to_s == x and y.to_i.to_s == y
							
						if	x.to_i.between?(0,(n.to_i) - 1) and y.to_i.between?(0,(n.to_i) - 1)
							
								
									map_size_checker(n.to_i,@default_number_of_driver,@default_number_of_store)	
									user_location = [].push(x.to_i).push(y.to_i)
									create_map(n.to_i)
									#set default item for store
									set_default_item
									#locate user 
									set_user(user_location)
									#create store
									create_default_store
									#create drivers
									create_random_driver(@default_number_of_driver)
									
									
							else
								
								puts "The map size is #{n} x #{n} , coordinate must between #{0} to #{n.to_i - 1}"
								print_usage
								error_exit_program
							
							end
						
						
						else
						puts  "User coordinate invalid"
						print_usage
						error_exit_program
						
						end
						
					else
					puts "Map size invalid"
					print_usage
					error_exit_program
					end
					
					
	
	
	end
	
	
	def with_filename_case(filename)
		require 'json'
		if File::exist?(filename)
			file = File.open(filename,"r")
		else
		puts "File doesn't exist"
		print_usage
		error_exit_program
		end
		
		data = JSON.load file
		#create map first
		map_size_checker(data['map_size'] , data["driver"].size , data["store"].size)
		create_map(data['map_size'])
		#create store and item next
		
		data["store"].each do |store|
			items = []
			store["items"].each do |item|
				new_item = Item.new(item["name"],item["price"])
				items.push(new_item)
			end
			create_store(store["name"],items,store["location"])
			
		end
		#create driver
		data["driver"].each do |driver|
			new_driver = create_driver(driver["name"],driver["location"])
			@drivers.push(new_driver)
		end
		
		
		#set user
		
		set_user(data["user_location"])
		
		
		file.close
	end
	
end


# Main Class 
# Main Class Method 

include OutputController
include InputController
include MainHandler
include NameController
include MapController
include UserController
include StoreController
include ItemController
include OrderController
include DriverController




@default_number_of_driver = 5
@default_number_of_store = 3
@used_name = []
@map
@drivers = []
@user
@default_items = []
@stores = []
@user_input 
@order
@order_history_filename = "order_logs.txt"




start_program_handler
main_menu_handler














