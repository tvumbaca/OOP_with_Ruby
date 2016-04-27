# This method takes an array and returns a sorted array using the bubble sort methodology.

def bubble_sort(array)
	n = array.length - 1

	loop do 
		swapped = false

		n.times do |index|
			if array[index] > array[index+1]
				array[index], array[index+1] = array[index+1], array[index]
				swapped = true
			end
		end
		break if !swapped
	end
  puts "The sorted array is: #{array}"
end

bubble_sort([5,3,4,1])


# Same as the above method eccept this one accepts a block which handles 
# the comparing functionality - similar to the spaceship operator "<=>"

def bubble_sort_by(array)
	n = array.length - 1

	loop do 
		swapped = false

		n.times do |index|
			if yield(array[index], array[index+1]) > 0  # yield accepts these two parameters that are sent to the yielded block!
				array[index], array[index+1] = array[index+1], array[index]
				swapped = true
			end
		end
		break if !swapped
	end
  puts "The sorted array is: #{array}"
end

bubble_sort_by(["hi","hello","hey"]) do |left,right|
	left.length - right.length
end
# modified the block so it returns the result in descending order
bubble_sort_by(["hello","good buy","ciao", "sianara sucker"]) { |left,right| right.length - left.length }
