braille_handle = File.open(ARGV[0], "r")

braille_text = braille_handle.read

braille_handle.close

english_text = braille_text
# dictionary.translate_with_split(english_text.chomp)
#
english_handle = File.open(ARGV[1], "w")

english_handle.write(english_text)

english_handle.close

puts "Created '#{ARGV[1]}' containing #{braille_text.chomp.delete("\n").size / 6} characters"
