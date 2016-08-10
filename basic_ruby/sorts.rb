

def bubble_sort(list)
	a = list.length

	loop do
		swapped = false
		(a-1).times do |i|
			if list[i] > list[i+1]
				list[i+1], list[i] = list[i], list[i+1]
				swapped = true
			end
		end

		break if swapped == false
	end

	puts list

end

bubble_sort([4,3,78,2,0,2])



def bubble_sort_by(list)
	a = list.length

	loop do
		swapped = false
		(a-1).times do |i|
			if yield(list[i], list[i+1]) > 0
				list[i+1], list[i] = list[i], list[i+1]
				swapped = true
			end
		end

		break if swapped == false
	end

	puts list
end


bubble_sort_by(["hi","hello","hey","heyyyyo"]) do |left,right|
	left.length - right.length
end