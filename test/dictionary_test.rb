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
end
