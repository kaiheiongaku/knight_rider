require 'minitest/autorun'
require 'minitest/pride'
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

  def test_convert

    assert_equal "0.\n.0\n00", @dictionary.convert("z")
  end

  def test_translate

    expected = "0.0...00\n..0.....\n........"
    assert_equal expected, @dictionary.translate("ab c")
  end

  def test_it_can_split_messages_at_40_characters

    message = "i am the king of the forest harumf harumf"
    expected = ["i am the king of the forest harumf harum", "f"]
    assert_equal expected, @dictionary.split_at_40_characters(message)

    message = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
    expected = ["abcdefghijklmnopqrstuvwxyzabcdefghijklmn", "opqrstuvwxyzabcdefghijklmnopqrstuvwxyzab", "cdefghijklmnopqrstuvwxyz"]
    assert_equal expected, @dictionary.split_at_40_characters(message)
  end

  def test_translate_with_split
    message =  "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    expected = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n0.\n..\n.."
    assert_equal expected, @dictionary.translate_with_split(message)

    message = "aa"
    expected = "0.0.\n....\n...."
    assert_equal expected, @dictionary.translate_with_split(message)
  end

  def test_convert_from_braille
    braille_message = ".0\n0.\n.."
    actual = @dictionary.convert_from_braille(braille_message)
    assert_equal "i", actual
  end
end
