module Enumerable
	def my_each
		for i in 0..self.length-1
			yield self[i]
		end
	end 

	def my_each_with_index
		for i in 0..self.length-1
			yield([self[i], i])
		end
	end

	def my_select
		array = []
		self.my_each do |i|
			array.push(i) if yield(i)
		end
		array
	end

	def my_all?
		all = true
		self.my_each do |i|
			if i == nil || i == false
				all = false
			elsif block_given?
				all = false unless yield(i)
			else
				all = false unless i
			end
		end
		all
	end

	def my_any?
		any = false
		self.my_each do |i|
			if i == nil || i == false
				next
			elsif block_given?
				any = true if yield(i)
			else
				any = true if i
			end
		end
		any
	end

	def my_none? 
		none = true
		self.my_each do |i|
			if i == nil || i == false
				next
			elsif block_given?
				none = false if yield(i)
			else
				none = false if i
			end
		end
		none
	end

	def my_count
		count = 0
		self.my_each do |i|
			if block_given?
				count += 1 if yield(i)
			else
				count += 1 
			end
		end
		count
	end

	def my_map
		array = []
		self.my_each do |i|
			array.push( yield(i) )
		end
		array
	end

	def my_inject(init = nil)
		#initializes accumulator to parameter if given
		#and adds value at index 0 to total
		if init
			accumulator = yield(init, self[0])
		else
			accumulator = self[0]
		end
		#counts from index 1 to end, yields each to block
		for i in 1..self.length-1  
			accumulator = yield(accumulator, self[i])
		end
		accumulator
	end		

	def multiply_els
		self.my_inject {|sum, n| sum * n}
	end

end

#puts [1, 2, 3, 4, 5, 6].my_inject {|sum, n| sum * n}
puts [2,4,5].multiply_els

