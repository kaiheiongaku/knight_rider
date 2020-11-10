require './lib/dictionary'

dictionary = Dictionary.new

braille_handle = File.open(ARGV[0], "r")

braille_text = braille_handle.read

braille_handle.close

english_text = dictionary.convert_from_braille(braille_text.chomp)
# dictionary.translate_with_split(english_text.chomp)
#
english_handle = File.open(ARGV[1], "w")

english_handle.write(english_text)

english_handle.close

puts "Created '#{ARGV[1]}' containing #{braille_text.chomp.delete("\n").size / 6} characters"
