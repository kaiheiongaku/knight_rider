require './lib/to_english_translator'

braille_handle = File.open(ARGV[0], "r")
braille_text = braille_handle.read
braille_handle.close

translator = ToEnglishTranslator.new(braille_text.chomp)
english_text = translator.full_translation

english_handle = File.open(ARGV[1], "w")
english_handle.write(english_text)
english_handle.close

puts "Created '#{ARGV[1]}' containing #{braille_text.chomp.delete("\n").size / 6} characters"
