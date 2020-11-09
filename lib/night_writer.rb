english_handle = File.open(ARGV[0], "r")

english_text = english_handle.read

english_handle.close

puts "Created '#{ARGV[1]}' containing #{english_text.size - 1} characters"

braille_text = english_text#translate method here

braille_handle = File.open(ARGV[1], "w")

braille_handle.write(braille_text)

braille_handle.close
