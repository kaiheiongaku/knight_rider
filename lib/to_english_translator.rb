require './lib/dictionary'

class ToEnglishTranslator
  attr_reader :message

  def initialize(message)
    @message = message
    @dictionary = Dictionary.new
  end

  def chomp_the_blocks(blocks)
    blocks.map do |block|
      block.chomp
    end
  end

  def split_braille_by_block(conversion = @message)
    block_array = []
    countdown = conversion
    until countdown.size == 0
      block_array << message.slice!(0..242)
    end
    chomp_the_blocks(block_array)
  end

  def split_braille_by_lines(block = @message)
    block.split("\n")
  end

  def split_lines_by_character_part(letters = @message)
    split_braille_by_lines(letters).map do |line|
      line.scan(/.{2}/)
    end
  end

  def extract_braille_letter_parts(block = @message)
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

  def assemble_braille_letters(block = @message)
    extract_braille_letter_parts(block).flat_map do |character_parts|
      character_parts.join("\n")
    end
  end

  def convert_multiple_letters_from_braille(block = @message)
    assemble_braille_letters(block).map do |letter|
      @dictionary.convert_from_braille(letter)
    end.join
  end

  def full_translation
    split_braille_by_block.map do |block|
      convert_multiple_letters_from_braille(block)
    end.join
  end
end
