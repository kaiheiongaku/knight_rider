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
      "l" => "0.\n0.\n0.",
      "m" => "00\n..\n0.",
      "n" => "00\n.0\n0.",
      "o" => "0.\n.0\n0.",
      "p" => "00\n0.\n0.",
      "q" => "00\n00\n0.",
      "r" => "0.\n00\n0.",
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

  def convert_to_braille(letter)
    @letter_equivalents[letter]
  end

  def convert_multiple_letters_to_braille(message)
    translation_array = []
    message.each_char do |character|
      translation_array << convert_to_braille(character)
    end
    translation_array
  end

  def braille_split_by_line(message)
    convert_multiple_letters_to_braille(message).map do |braille_character|
      braille_character.split("\n")
    end
  end

  def braille_by_row(message, row_number)
    braille_split_by_line(message).map do |character_set|
      character_set[row_number]
    end
  end

  def micro_translate(message)
    top_row    = braille_by_row(message, 0)
    middle_row = braille_by_row(message, 1)
    bottom_row = braille_by_row(message, 2)
    top_row.join + "\n" + middle_row.join + "\n" + bottom_row.join
  end

  def split_at_40_characters(message)
    message.scan(/.{1,40}/)
  end

  def macro_translate(message)
    split_at_40_characters(message).map do |forty_character_chunk|
      micro_translate(forty_character_chunk)
    end.join("\n")
  end

  def convert_from_braille(letter)
    @letter_equivalents.key(letter)
  end

  def chomp_the_blocks(blocks)
    blocks.map do |block|
      block.chomp
    end
  end

  def split_braille_by_block(message)
    block_array = []
    countdown = message
    until countdown.size == 0
      block_array << message.slice!(0..242)
    end
    chomp_the_blocks(block_array)
  end

  def split_braille_by_lines(block)
    block.split("\n")
  end

  def split_lines_by_character_part(letters)
    split_braille_by_lines(letters).map do |line|
      line.scan(/.{2}/)
    end
  end

  def extract_braille_letter_parts(block)
    n = 0
    assembly_array = []
    while assembly_array.size < split_lines_by_character_part(block)[0].size
      character_assembly = split_lines_by_character_part(block).map do |line|
        line[n]
      end
      assembly_array << character_assembly
      n += 1
    end
    assembly_array
  end

  def assemble_braille_letters(block)
    extract_braille_letter_parts(block).flat_map do |character_parts|
      character_parts.join("\n")
    end
  end

  def convert_multiple_letters_from_braille(message)
    assemble_braille_letters(message).map do |letter|
      convert_from_braille(letter)
    end.join
  end

  def convert_multiple_lines_from_braille(message)
    split_braille_by_block(message).map do |block|
      convert_multiple_letters_from_braille(block)
    end.join
  end
end
