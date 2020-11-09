english_handle = File.open(ARGV[0], "r")

english_text = english_handle.read

english_handle.close

puts "Created '#{ARGV[1]}' containing #{english_text.size - 1} characters"

# capitalized_text = incoming_text.upcase
#
# writer = File.open(ARGV[1], "w")
#
# writer.write(capitalized_text)
#
# writer.close
