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


	def my_map(&someProc)
		array = []
		self.my_each do |i|
			if someProc
				array.push( someProc.call(i))
			else
				array.push( yield(i) )
			end
		end
		array
	end


	def my_inject(init = nil)
		if block_given?
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
		else
			accumulator = self[0]
			#executes loop with parameter method call
			for i in 1..self.length-1 
				m = accumulator.method(init)
				accumulator = m.call(self[i])
			end
		end
		accumulator
	end		


	def multiply_els
		self.my_inject {|sum, n| sum * n}
	end

end


#hash = Hash.new
#["grass", "tree", "sun"].my_each_with_index { |i, index| hash[i] = index }
#puts hash


#puts [1,2,3,4].my_select { |x| x.even? }


#puts [1,2,3,4, nil].my_none? {|x| x>5}


#puts [1,2,3,4].my_count {|x| x>2 }


#someProc = Proc.new { |x| x*2}
#puts [1, 2, 3, 4].my_map(&someProc)


#puts [1,2,3,4,5].my_inject(2) {|sum, n| sum + n}
#puts [1,2,3,4,5].my_inject(:+)


#puts [1,2,3,4].multiply_els