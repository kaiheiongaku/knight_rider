class Dictionary
  attr_reader :letter_equivalents

  def initialize
    @letter_equivalents = {
      " " => "..\n..\n..",
      "a" => ".0\n00\n00",
      "b" => ".0\n.0\n00",
      "c" => "..\n00\n00",
      "d" => "..\n0.\n00",
      "e" => ".0\n0.\n00",
      "f" => "..\n.0\n00",
      "g" => "..\n..\n00",
      "h" => ".0\n..\n00",
      "i" => "0.\n.0\n00",
      "j" => "0.\n..\n00",
      "k" => ".0\n00\n.0",
      "l" => ".0\n.0\n.0",
      "m" => "..\n00\n.0",
      "n" => "..\n0.\n.0",
      "o" => ".0\n0.\n.0",
      "p" => "..\n.0\n.0",
      "q" => "..\n..\n.0",
      "r" => ".0\n..\n.0",
      "s" => "0.\n.0\n.0",
      "t" => "0.\n..\n.0",
      "u" => ".0\n00\n..",
      "v" => ".0\n.0\n..",
      "w" => "0.\n..\n0.",
      "x" => "..\n00\n..",
      "y" => "..\n0.\n..",
      "z" => ".0\n0.\n.."
    }
  end

  def convert(letter)
    @letter_equivalents[letter]
  end

  def translate(message)
    translation_array = []
    message.each_char do |character|
      translation_array << convert(character)
    end
    braille_split_by_line = translation_array.map do |braille_character|
      braille_character.split("\n")
    end
    top_row = braille_split_by_line.map do |character_set|
      character_set.first
    end
    middle_row = braille_split_by_line.map do |character_set|
      character_set[1]
    end
    bottom_row = braille_split_by_line.map do |character_set|
      character_set.last
    end
    top_row.join + "\n" + middle_row.join + "\n" + bottom_row.join
  end

  def split_at_40_characters(message)
    message.scan(/.{1,40}/)
  end

  def translate_with_split(message)
    translation = split_at_40_characters(message).map do |forty_character_chunk|
      translate(forty_character_chunk)
    end
    translation.join("\n")
  end
end
