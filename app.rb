class Map

	attr_reader :height
	attr_reader :width
	attr_reader :taken_coordinate
	
	
	def initialize (height,width)
		@height = height
		@width = width
		@taken_coordinate = []
		@map_image = Array.new(height,".") 
		@map_image.each do 
			@map_image.push(Array.new(width,"."))
			end
		
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
	
	def show_map
		@map_image.each do |height|
			height.each do |element|
				puts element
			end
		end
	
	
	end
	
	def add_to_map_image(object)
		x,y=*object.coordinate
		if(object.class == Driver)
			@map_image[x][y] = "d"
		end
		if(object.class == Store)
			@map_image[x][y] = "s"
		end
		if(object.class == User)
			@map_image[x][y] = "u"
		end
	
	end
	
	
	def add_to_taken_coordinate(coordinate)
		@taken_coordinate.push(coordinate)
	
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
	
	
	def calculate_fee(unit_cost , distance)
	
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
	attr_reader :name, :item
	
	def initialize (store_name)
		@name = store_name
		@item = []
	end
	
	def add_item (item)
		@item.push(item)
	end
	
	def print_information
		puts "Store - #{@name}"
		puts "Location : #{@coordinate}"
		puts "Item(s) available :"
		@item.each_with_index do |item,number|
			puts "#{number}. #{item.name} : Rp:#{item.price}"
		end
		
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
		flag = 0
		
		#puts "i will find path from #{@start_position.coordinate} to  #{@end_position.coordinate}"
		while has_possible_step?
				
				if flag == 1 
					break
				end
				
				
				steps.clear
				steps = possible_step	# sort dulu harusnya semua steps jadi biar dia ambil langkah paling dekat dlu ke tujun
										# ini dia malah keliling gajelas terkadang 
				
				#puts "i am looping , here possible step from my current "
				#steps.each do |a|
				#puts "#{a}"
				#end
				
				
				
				
				while !(steps.empty?)
				next_step = steps[0]
				#puts "i choose #{next_step} and my last step is #{@last_visited.last}"	#pilih terdekat seharusnya
				
				if next_step == @end_position.coordinate
					
					if distance == 0		#flag untuk kalau hanya satu step langsung sampai,udah jelas shortest path , gausa kumpuli path lain 
						flag = 1		
					end
					path.push(next_step)
					distance += 1
					@paths.push(path.drop(0))
					@last_visited.clear
					@last_visited = [].push(start_position.coordinate)
					@distances.push(distance)
					@current_position = @start_position
					distance = 0
					path.clear
					#puts "i got finish"
					break
					
				
				elsif !(@visited.include?(next_step))
					@visited.push(next_step)
					distance += 1
					path.push(next_step)
					@last_visited.push(next_step)
					@current_position.coordinate = next_step
					break
					
					
				
				elsif @last_visited.last == next_step 	#untuk mundur
					
					@last_visited.pop
					path.pop
					distance--
					@current_position.coordinate == next_step
					break
				
				
				
				
				end
				
				
				end
				
		
		
		
		
		end
		
		
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
	
	#hanya test 
	def show_all_rute
		
		
		@distances.each.with_index(1) do |d,i|
		
		puts "the #{i} rute  has distance : #{d}"
		end
		
		
		@paths.each.with_index(1) do |path,i|
		puts "Here the #{i} rute "
		print "#{@start_position.coordinate} -"
		path.each do |coordinate|
			print "#{coordinate} - "
		end
		
		
		end
	
	end
		
	
	def has_path?
		@paths.size > 0
	
	end
		
		

end

class OutputController


end


module NameGenerator
	Name = ["glien","rizky","nufi","prince","koko","paddy","dody","rommel","taro","boy","ivan","bimo","jovan","david","martin","juanda","daniel","yudhi"]
	
	def NameGenerator.generate 
		new = Name[Random.new.rand(0..(Name.size - 1))]
	end
	
end






# Main Class Method



def is_name_used?(name)
	
	@used_name.include?(name)
	
end

def unuse_name(name)
	@used_name.delete_at(@used_name.index(name))
		
end

def generate_unused_name
	name = NameGenerator::generate
	while @used_name.include?(name)
		name = NameGenerator::generate
	end
	@used_name.push(name)
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
		@stores.push(store)
		
	end
	
	

end

def create_item
	

end

def create_default_driver(number_of_driver)
	
	number_of_driver.times do  
		new_driver = generate_new_driver(generate_unused_name)
		@drivers.push(new_driver)
	end
	
	
	
end


def print_all_driver
	@drivers.each do |driver|
	puts "driver name : #{driver.name} , location : #{driver.coordinate}  rating : #{driver.rating}"
	
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

#only for test
def print_all_item

	@items.each do |item|
	puts "#{item.name} : #{item.price}"
	end

end

def print_all_store
	@stores.each do |store|
		store.print_information
		
	end

end

def set_user(name = "kylex",location=@map.generate_new_coordinate)
	@user = User.new(name)
	@user.locate(location)

end

def create_map(height=20,width=20)
	@map = Map.new(height,width)
end

# Main Class 


@used_name = []
@map
@drivers = []
@user
@items = []
@stores = []

#default case 

#create  map , default = 20x20
create_map
#set default item for store
set_default_item
#create store
create_default_store
#create drivers
create_default_driver(5)
#set user 
set_user
#cek
print_all_driver
#cek store dan item
print_all_store
#show_map
@map.show_map












