class Dictionary
  attr_reader :letter_equivalents

  def initialize
    @letter_equivalents = {
      " " => "..\n..\n..",
      "a" => "0.\n..\n..",
      "b" => "0.\n0.\n..",
      "c" => "00\n..\n..",
      "d" => "00\n.0\n..",
      "e" => "0.\n.0\n..",
      "f" => "00\n0.\n..",
      "g" => "00\n00\n..",
      "h" => "0.\n00\n..",
      "i" => ".0\n0.\n..",
      "j" => ".0\n00\n..",
      "k" => "0.\n..\n0.",
      "l" => "0.\n.0\n0.",
      "m" => "00\n..\n0.",
      "n" => "00\n.0\n0.",
      "o" => "0.\n.0\n0.",
      "p" => "00\n0.\n0.",
      "q" => "00\n00\n0.",
      "r" => ".0\n00\n0.",
      "s" => ".0\n0.\n0.",
      "t" => ".0\n00\n0.",
      "u" => "0.\n..\n00",
      "v" => "0.\n0.\n00",
      "w" => ".0\n00\n.0",
      "x" => "00\n..\n00",
      "y" => "00\n.0\n00",
      "z" => "0.\n.0\n00"
    }
  end

  def convert(letter)#add convert to braille and be sure to change in tests
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

  def convert_from_braille(letter)
    @letter_equivalents.key(letter)
  end

  def split_braille_by_lines(message)
    message.split("\n")
  end

  def split_lines_by_character_part(letters)
    split_braille_by_lines(letters).map do |line|
      line.scan(/.{2}/)
    end
  end

  # def assemble_braille_letters
  #   array_of_lines = split_braille_lines
  #   x = 0
  #   y = 1
  #   while array_of_lines[0].size != 0
  #


  # def convert_multiple_letters_from_braille(message)

end
