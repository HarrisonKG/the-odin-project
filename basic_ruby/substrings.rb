def substrings(string, dictionary)
	freq = Hash.new(0)
	dictionary.each{ |word| 
		if string.downcase.include? word
			freq[word] = string.downcase.scan(/#{word}/).length 
		end
	}
	puts freq
end



dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("Howdy partner, sit down! How's it going?", dictionary)
