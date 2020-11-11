require './lib/dictionary'

class ToBrailleTranslator
  attr_reader :message

  def initialize(message)
    @message = message
    @dictionary = Dictionary.new
  end

  def convert_multiple_letters_to_braille(conversion = @message)
    translation_array = []
    conversion.each_char do |character|
      translation_array << @dictionary.convert_to_braille(character)
    end
    translation_array
  end

  def braille_split_by_line(conversion = @message)
    convert_multiple_letters_to_braille(conversion).map do |braille_character|
      braille_character.split("\n")
    end
  end

  def braille_by_row(conversion = @message, row_number)
    braille_split_by_line(conversion).map do |character_set|
      character_set[row_number]
    end
  end

  def micro_translate(conversion = @message)
    top_row    = braille_by_row(conversion, 0)
    middle_row = braille_by_row(conversion, 1)
    bottom_row = braille_by_row(conversion, 2)
    top_row.join + "\n" + middle_row.join + "\n" + bottom_row.join
  end

  def split_at_40_characters
    @message.scan(/.{1,40}/)
  end

  def macro_translate
    split_at_40_characters.map do |forty_character_chunk|
      micro_translate(forty_character_chunk)
    end.join("\n")
  end
end
