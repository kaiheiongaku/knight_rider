require './test/test_helper'
require './lib/dictionary'


class DictionaryTest < Minitest::Test

  def setup
    @dictionary = Dictionary.new
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Dictionary, @dictionary
    assert_equal Hash, @dictionary.letter_equivalents.class
    assert_equal 27, @dictionary.letter_equivalents.size
    assert_equal "0.\n.0\n00", @dictionary.letter_equivalents['z']
  end

  def test_convert_to_braille
    assert_equal "0.\n.0\n00", @dictionary.convert_to_braille("z")
  end

  def test_convert_multiple_letters_to_braille
    message = "ab c"
    actual = @dictionary.convert_multiple_letters_to_braille(message)
    expected = ["0.\n..\n..", "0.\n0.\n..", "..\n..\n..", "00\n..\n.."]
    assert_equal expected, actual
  end

  def test_braille_split_by_line
    message = "ab c"
    expected =  [["0.", "..", ".."], ["0.", "0.", ".."], ["..", "..", ".."], ["00", "..", ".."]]
    actual = @dictionary.braille_split_by_line(message)
    assert_equal expected, actual
  end

  def test_braille_by_row
    message = "ab c"
    expected = ["..", "0.", "..", ".."]
    actual = @dictionary.braille_by_row(message, 1)
    assert_equal expected, actual
  end

  def test_micro_translate
    message = "ab c"
    expected = "0.0...00\n..0.....\n........"
    actual = @dictionary.micro_translate(message)
    assert_equal expected, actual
  end

  def test_it_can_split_messages_at_40_characters
    message = "i am the king of the forest harumf harumf"
    expected = ["i am the king of the forest harumf harum", "f"]
    assert_equal expected, @dictionary.split_at_40_characters(message)

    message = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
    expected = ["abcdefghijklmnopqrstuvwxyzabcdefghijklmn", "opqrstuvwxyzabcdefghijklmnopqrstuvwxyzab", "cdefghijklmnopqrstuvwxyz"]
    assert_equal expected, @dictionary.split_at_40_characters(message)
  end

  def test_macro_translate
    message =  "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    expected = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n0.\n..\n.."
    assert_equal expected, @dictionary.macro_translate(message)

    message = "aa"
    expected = "0.0.\n....\n...."
    assert_equal expected, @dictionary.macro_translate(message)
  end

  def test_convert_from_braille
    braille_message = ".0\n0.\n.."
    actual = @dictionary.convert_from_braille(braille_message)
    assert_equal "i", actual
  end

  def test_chomp_the_blocks
    blocks = ["0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n", "0.\n..\n.."]
    expected = ["0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................", "0.\n..\n.."]
    actual = @dictionary.chomp_the_blocks(blocks)
    assert_equal expected, actual
  end

  def test_split_braille_by_block
    message = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n0.\n..\n.."
    expected = ["0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................", "0.\n..\n.."]
    actual = @dictionary.split_braille_by_block(message)
    assert_equal expected, actual
  end

  def test_split_braille_by_lines
    letters = ".0.0\n0.0.\n...."
    actual = @dictionary.split_braille_by_lines(letters)
    assert_equal [".0.0", "0.0.", "...."], actual
  end

  def test_split_lines_by_character_part
    letters = ".0.0\n0.0.\n...."
    expected = [[".0", ".0"], ["0.", "0."], ["..", ".."]]
    actual = @dictionary.split_lines_by_character_part(letters)
    assert_equal expected, actual
  end

  def test_assemble_braille_letters
    letters = ".0.0\n0.0.\n...."
    expected = [".0\n0.\n..", ".0\n0.\n.."]
    actual = @dictionary.assemble_braille_letters(letters)
    assert_equal expected, actual
  end

  def test_convert_multiple_letters_from_braille
    braille_message = ".0.0\n0.0.\n...."
    actual = @dictionary.convert_multiple_letters_from_braille(braille_message)
    assert_equal "ii", actual
  end

  def test_convert_multiple_lines_from_braille
    message = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n0.\n..\n.."
    expected = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    actual = @dictionary.convert_multiple_lines_from_braille(message)
    assert_equal expected, actual
  end
end
