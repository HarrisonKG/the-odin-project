require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = 'e179a6973728c4dd3fb1204283aaccb5'

# makes zipcode exactly 5 digits long
def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5,"0")[0..4]
end

# returns array of legislators
def legislators_by_zipcode(zipcode)
	Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def write_letter(id, letter)
	Dir.mkdir("output") unless Dir.exists? "output"
	filename = "output/thanks_#{id}.html"

	File.open(filename, 'w') do |file|
		file.puts letter
	end
end


contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

# creating template requires loading file contents as a string
# then providing that as a parameter for the new ERB template
template_letter = File.read "template.erb"
erb_template = ERB.new template_letter

contents.each do |row|
	id = row[0]
	name = row[:first_name]
	zipcode = clean_zipcode(row[:zipcode])
	legislators = legislators_by_zipcode(zipcode)
	
	letter = erb_template.result(binding)
	write_letter(id, letter)
end
