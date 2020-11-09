require './lib/dictionary'
dictionary = Dictionary.new

english_handle = File.open(ARGV[0], "r")

english_text = english_handle.read

english_handle.close

braille_text = dictionary.convert(english_text.chomp)

braille_handle = File.open(ARGV[1], "w")

braille_handle.write(braille_text)

braille_handle.close

puts "Created '#{ARGV[1]}' containing #{english_text.chomp.size} characters"
