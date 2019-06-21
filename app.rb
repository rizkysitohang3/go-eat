class Map

	attr_reader :height
	attr_reader :width
	attr_reader :taken_coordinate
	
	
	def initialize (height,width)
		@height = height
		@width = width
		@taken_coordinate = []
		@map_image = Array.new(height) {Array.new(width)}
		
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
		add_to_taken_coordinate(coordinate)
		coordinate
	
	end
	
	def show_map
		
	
	
	end
	
	private
	
	
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
		x>0
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
		y<(@map.length - 1)
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
	attr_reader :distances , :start_position , :end_position , :paths
	
	
	def initialize (start_position , end_position , map)
		@start_position = CoordinateInterface.new(start_position,map)
		@end_position = CoordinateInterface.new(end_position,map)		
		@paths = []
		@distances = []
		@visited = []
		@current_position = @start_position
		@map = map
		
	end
	
	
	def find_path
		path = []
		distance = 0
		
		if has_possible_step?
				
				steps = possible_step
				next_step = steps.pop
				
				if step == @end_position.coordinate
					distance++;
					@paths.push(path)
					@distances.push(distance)
					@current_position = @start_position
					distance = 0
					path.clear
					
				
				elsif !(@visited.include?(next_step))
					@visited.push(next_step)
					distance++;
					path.push(next_step)
					@current_position.coordinate = next_step
					
					
				
				elsif @visited.last == next_step
					path.pop
					distance--;
					@current_position.coordinate == next_step
					
				
				
				elsif steps.empty?
				
				else
				
				
				end
				
				
			
			
		
		
		else
		
		
		end
		
		
	end
	
	def has_possible_step?
		(@current_position.have_up? and !(map.taken_coordinate.include?(@current_position.up)) ) or 
		(@current_position.have_down? and !(map.taken_coordinate.include?(@current_position.down)) ) or 
		(@current_position.have_left? and !(map.taken_coordinate.include?(@current_position.left)) ) or 
		(@current_position.have_right? and !(map.taken_coordinate.include?(@current_position.right)) )
		
	end	
	
	
	def possible_step
		steps = []
		
		if (@current_position.have_up? and !(map.taken_coordinate.include?(@current_position.up)) and !(blocked_step.include?(@current_position.up)) )
			steps.push(@current_position.up)
		end
		
		if (@current_position.have_down? and !(map.taken_coordinate.include?(@current_position.down)) and !(blocked_step.include?(@current_position.down)))
			steps.push(@current_position.down)
		end
		
		if (@current_position.have_left? and !(map.taken_coordinate.include?(@current_position.left)) and !(blocked_step.include?(@current_position.left)))
			steps.push(@current_position.left)
		end
		
		if (@current_position.have_right? and !(map.taken_coordinate.include?(@current_position.right)) and !(blocked_step.include?(@current_position.right)))
			steps.push(@current_position.right)
		end
		
		steps
		
	
	end
		
	def closest_step(coordinates)
		
		
	end
	
	
	
	def move
		
	
	end
	
	
	def undo_move
	
	
	end
	
		
		

end

class OutputController


end








