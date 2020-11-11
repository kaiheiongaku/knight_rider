require './lib/to_braille_translator'

english_handle = File.open(ARGV[0], "r")
english_text = english_handle.read
english_handle.close

translator = ToBrailleTranslator.new(english_text.chomp)
braille_text = translator.macro_translate

braille_handle = File.open(ARGV[1], "w")
braille_handle.write(braille_text)
braille_handle.close

puts "Created '#{ARGV[1]}' containing #{english_text.chomp.size} characters"
