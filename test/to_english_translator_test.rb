require 'minitest/autorun'
require 'minitest/pride'
require './lib/to_english_translator'

class ToEnglishTranslatorTest < Minitest::Test

  def test_it_exists_and_has_attributes
    translator = ToEnglishTranslator.new(".0\n0.\n..")
    assert_equal ".0\n0.\n..", translator.message
  end

  def test_chomp_the_blocks
    translator = ToEnglishTranslator.new(".0\n0.\n..")

    blocks = ["0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n", "0.\n..\n.."]
    expected = ["0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................", "0.\n..\n.."]
    actual = translator.chomp_the_blocks(blocks)
    assert_equal expected, actual
  end

  def test_split_braille_by_block
    message = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n0.\n..\n.."
    translator = ToEnglishTranslator.new(message)

    expected = ["0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................", "0.\n..\n.."]
    actual = translator.split_braille_by_block
    assert_equal expected, actual
  end

  def test_split_braille_by_lines

    translator = ToEnglishTranslator.new(".0.0\n0.0.\n....")
    actual = translator.split_braille_by_lines
    assert_equal [".0.0", "0.0.", "...."], actual
  end

  def test_split_lines_by_character_part
    translator = ToEnglishTranslator.new(".0.0\n0.0.\n....")
    expected = [[".0", ".0"], ["0.", "0."], ["..", ".."]]
    actual = translator.split_lines_by_character_part
    assert_equal expected, actual
  end

  def test_extract_braille_letter_parts
    translator = ToEnglishTranslator.new(".0.0\n0.0.\n....")

    expected = [[".0", "0.", ".."], [".0", "0.", ".."]]
    actual = translator.extract_braille_letter_parts
    assert_equal expected, actual
  end

  def test_assemble_braille_letters
    translator = ToEnglishTranslator.new(".0.0\n0.0.\n....")

    expected = [".0\n0.\n..", ".0\n0.\n.."]
    actual = translator.assemble_braille_letters
    assert_equal expected, actual
  end

  def test_convert_multiple_letters_from_braille
    translator = ToEnglishTranslator.new(".0.0\n0.0.\n....")

    actual = translator.convert_multiple_letters_from_braille
    assert_equal "ii", actual
  end

  def test_convert_multiple_lines_from_braille
    message = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n0.\n..\n.."
    translator = ToEnglishTranslator.new(message)

    expected = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    actual = translator.convert_multiple_lines_from_braille
    assert_equal expected, actual

    translator = ToEnglishTranslator.new(".0.0\n0.0.\n....")
    actual = translator.convert_multiple_lines_from_braille
    assert_equal "ii", actual
  end
end
