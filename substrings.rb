# A method #substrings that takes a string as the first argument and then an 
# array of valid substrings (your dictionary) as the second argument. 
# It returns a hash listing each substring that was found in the original string 
# and how many times it was found.

dictionary = ["i", "it", "now", "how", "cow", "ow", "it", "brown", "own", "down", "sit"]

def substrings(words, dict)

	word_counts = Hash.new
	words = words.downcase

	# Loop checks each word in dictionary to see if it's in the string
	dict.each do |w|
		if words.include?(w)
			# If a dictionary word is found in the string,
			# it then scans entire string to count how many occurances
			matches = words.scan(w).count
			# Saves the result to the hash
			word_counts[w] = matches.to_s
		end
	end

	puts word_counts

end

substrings("How now brown cow? Sit down NOW!", dictionary)