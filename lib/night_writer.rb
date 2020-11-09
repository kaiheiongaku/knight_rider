english_handle = File.open(ARGV[0], "r")

english_text = english_handle.read

english_handle.close

puts "Created 'braille_text' containing #{english_text.size} characters"

# capitalized_text = incoming_text.upcase
#
# writer = File.open(ARGV[1], "w")
#
# writer.write(capitalized_text)
#
# writer.close
