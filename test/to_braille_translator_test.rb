require './test/test_helper'
require './lib/to_braille_translator'

class ToBrailleTranslatorTest < Minitest::Test

  def setup
    @braille_translator = ToBrailleTranslator.new("ab c")
  end

  def test_it_exists_and_has_attributes
    assert_equal "ab c", @braille_translator.message
  end

  def test_convert_multiple_letters_to_braille
    actual = @braille_translator.convert_multiple_letters_to_braille
    expected = ["0.\n..\n..", "0.\n0.\n..", "..\n..\n..", "00\n..\n.."]
    assert_equal expected, actual
  end

  def test_braille_split_by_line
    expected =  [["0.", "..", ".."], ["0.", "0.", ".."], ["..", "..", ".."], ["00", "..", ".."]]
    actual = @braille_translator.braille_split_by_line
    assert_equal expected, actual
  end

  def test_braille_by_row
    expected = ["..", "0.", "..", ".."]
    actual = @braille_translator.braille_by_row(1)
    assert_equal expected, actual
  end

  def test_micro_translate
    expected = "0.0...00\n..0.....\n........"
    actual = @braille_translator.micro_translate
    assert_equal expected, actual
  end

  def test_it_can_split_messages_at_40_characters
    message = "i am the king of the forest harumf harumf"
    braille_translator = ToBrailleTranslator.new(message)

    expected = ["i am the king of the forest harumf harum", "f"]
    assert_equal expected, braille_translator.split_at_40_characters

    message = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
    braille_translator = ToBrailleTranslator.new(message)

    expected = ["abcdefghijklmnopqrstuvwxyzabcdefghijklmn", "opqrstuvwxyzabcdefghijklmnopqrstuvwxyzab", "cdefghijklmnopqrstuvwxyz"]
    assert_equal expected, braille_translator.split_at_40_characters
  end

  def test_macro_translate
    message =  "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    braille_translator = ToBrailleTranslator.new(message)

    expected = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n0.\n..\n.."
    assert_equal expected, braille_translator.macro_translate

    message = "aa"
    braille_translator = ToBrailleTranslator.new(message)

    expected = "0.0.\n....\n...."
    assert_equal expected, braille_translator.macro_translate
  end
end
