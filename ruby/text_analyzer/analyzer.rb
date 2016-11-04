# run program as <filename.rb> <text_to_analyze.txt>

# build array of fluff words
stopwords = %w{the a by on for of are with just but and to the my I has some in}
# #readlines reads entire file into an array, line by line
lines = File.readlines(ARGV[0])
# counts size of array
line_count = lines.size 
# joins array into single string
text = lines.join

# count the characters
total_characters = text.length
total_chars_nospaces = text.gsub(/\s+/, '').length

# count words, sentences, paragraphs
word_count = text.split.length
sentence_count = text.split(/\.|\?|!/).length
paragraph_count = text.split(/\n\n/).length

# make list of non-stopwords, count them, calculate ratio
all_words = text.scan(/\w+/)
quality_words = all_words.select{ |word| !stopwords.include?(word) }
quality_percentage = ((quality_words.length.to_f / all_words.length.to_f) * 100).to_i

# summarize text using medium-length sentences that contain is & are
sentences = text.gsub(/\s+/, ' ').strip.split(/\.|\?|!/)
sentences_sorted = sentences.sort_by { |sentence| sentence.length }
one_third = sentences_sorted.length / 3
ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
ideal_sentences = ideal_sentences.select { |sentence| sentence =~ /is|are/ }

# output results
puts "#{line_count} lines"
puts "#{total_characters} characters"
puts "#{total_chars_nospaces} characters excluding whitespace"
puts "#{word_count} words"
puts "#{sentence_count} sentences"
puts "#{paragraph_count} paragraphs"
puts "#{sentence_count / paragraph_count} sentences per paragraph (on average)"
puts "#{word_count / sentence_count} words per sentence (on average)"
puts "#{quality_percentage}% of words are non-fluff words"
puts "Summary:\n\n" + ideal_sentences.join(". ")

